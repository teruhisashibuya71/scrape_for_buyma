#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

# selenium
# 国の設定変更が必要
# 繰り返し条件 ページネーションの最後の要素のhrefが空欄になるまで
# 価格取得方法 同じクラス名で定価/セールを表示  最初に表示されるのが定価なのでat_cssで取得
module Corsocomo

    def corsocomo_onetime_crawl_selenium(doc, search_price)
        products = doc.css('.plp-product')
        products.each do |product|
            #定価もセール価格も同じclass="price-label-10cc" 最初に表示される方が定価なのでat_cssで取得すればOK
            if (product.at_css('.price-label-10cc').inner_text.include?(search_price)) then
                puts "https://corsocomofashion.com/" + product.css('a').attribute("href").value
            end
        end
    end


    def corsocomo_crawl_selenium(brand_home_url, search_price)
        
        #ヘッドレス
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)

        #通常
        # driver = Selenium::WebDriver.for :chrome
        # wait = Selenium::WebDriver::Wait.new(timeout: 15)
        # driver.manage.window.resize_to(1300,1000)
        # driver.get(brand_home_url)

        #商品価格調整
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #クッキーウインドウがあれば消去する
        if (driver.find_elements(:id, 'CybotCookiebotDialog').size != 0) then
            driver.execute_script('document.getElementById("CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll").click()')
        end

        #メルマガ登録ウインドウがあれば消去する
        if (driver.find_elements(:class, 'newsletter-popup-content').size != 0) then
            driver.execute_script('document.getElementsByClassName("close-newsletter-popup")[0].click()')
        end

        #国の切り替えボタンが表示されるまで待つ 表示されたらクリックしてjapanが表示される位置までスクロール
        wait.until { driver.find_element(:xpath => '//*[@id="choice-country-btn"]').displayed? }

        #国のボタンをクリック
        driver.find_element(:id, 'choice-country-btn').click
        #国選択リストの情報を取得 
        country_list = driver.find_element(:id, "CountryList")

        #表示された国選択リスト位置情報を取得  左上端から少し右下に移動してリストの上にカーソルを乗せる
        driver.action.move_by(country_list.location.x + 30, country_list.location.y + 40)
        #国選択リストウィンドウをスクロールしてオランダをクリック xpathより日本はリスト上87番目のアイテム
        driver.execute_script('document.getElementsByClassName("disclosure__item")[84].scrollIntoView();')
        driver.find_elements(:class, 'tinyBig')[85].click

        #ページ送り部分を含むメインエリアが表示されるまで待つ
        wait.until { driver.find_element(:id => "MainContent").displayed? }

        #ページ送りのHTML要素が存在するなら繰り返し処理を実行
        if (driver.find_elements(:class, 'custom-pagination').size >= 1) then
            doc = Nokogiri::HTML.parse(driver.page_source)
            
            #最後のaタグのhref属性が空欄になるまで処理を繰り返す
            until (doc.css('.custom-pagination').css('div').last.css('a').attribute("href").to_s.empty?) do            
            corsocomo_onetime_crawl_selenium(doc, search_price)
                #次ページ移動用のリンクをクリック
                driver.find_elements(:class, 'pagination-button').last.click
                #商品が表示されるまで待ち、docを詰め替える
                wait.until { driver.find_element(:id => "MainContent").displayed? }
                doc = Nokogiri::HTML.parse(driver.page_source)
            end
            #最後に一度クローリングして終了
            #puts driver.current_url
            corsocomo_onetime_crawl_selenium(doc, search_price)
        else
            #ページネーションがない場合は1度だけクロール
            doc = Nokogiri::HTML.parse(driver.page_source)
            corsocomo_onetime_crawl_selenium(doc, search_price)
        end
    end
end