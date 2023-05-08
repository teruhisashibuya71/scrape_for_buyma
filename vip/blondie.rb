#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module Blondie

    def blondie_crawl_selenium(brand_home_url, search_price)
        
        #ヘッドレスオプション
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}

        #ノーマル
        #driver = Selenium::WebDriver.for :chrome
        #最大待ち時間を設定
        wait = Selenium::WebDriver::Wait.new(:timeout => 15)
        driver.manage.window.resize_to(1300,1000)
        
        #指定のURLにアクセス
        driver.get(brand_home_url)

        sleep 4

        #発送先の国指定欄が表示されるまで待つ
        wait.until { driver.find_element(:xpath => "//*[@id='html-body']/div[4]/footer/div/div[2]/a").displayed?}
        #ここで待たないとJPが表示されない　表示されていない状態ではクリックしても国選択用のウインドウが出てこない
        
        #配送先国の情報を取得する 
        shipping_country = driver.find_element(:xpath => "//*[@id='html-body']/div[4]/footer/div/div[2]/a").text
        
        sleep 1

        #cookieウインドウの表示があるならOKを押して消す
        if (driver.find_elements(:id, 'cookie-law-hide').size != 0) then
            driver.execute_script('document.getElementById("cookie-law-hide").click()')
        end
        #wait.until { driver.find_element(:id => "cookie-law-hide").displayed?}
        #driver.execute_script('document.getElementById("cookie-law-hide").click()')

        #テキストがITを含んでない場合は 国設定を変更する処理を実行する
        if (!shipping_country.include?("IT")) then
            
            #shipping to をクリックする
            wait.until { driver.find_element(:xpath => "//*[@id='html-body']/div[4]/footer/div/div[2]/a").displayed?}

            #不定期なnewslatter対応
            if (driver.find_elements(:id, 'modal-content-111').size != 0) then
                driver.execute_script('document.getElementsByClassName("action-close")[0].click()')
            end
            # doc = Nokogiri::HTML.parse(driver.page_source)
            # if doc.css('#modal-content-111').size > 0
            #     puts "バナーウインドウをキャッチ"
            #     driver.execute_script('document.getElementsByClassName("action-close")[0].click()')
            # end
            driver.find_element(:xpath => "//*[@id='html-body']/div[4]/footer/div/div[2]/a").click
            
            
            #「Europe」のプルダウンが表示されるまで待ってからクリック 
            wait.until { driver.find_element(:xpath => "//*[@id='continent-list']/div[3]/div").displayed?}
            
            #不定期なnewslatter対応
            if (driver.find_elements(:id, 'modal-content-111').size != 0) then
                driver.execute_script('document.getElementsByClassName("action-close")[0].click()')
            end
            
            driver.find_element(:xpath => "//*[@id='continent-list']/div[3]/div").click
            
            #「italy」が画面に表示されるまで待ってからクリックする
            wait.until { driver.find_element(:xpath => "//*[@id='continent-list']/div[4]/ul/li[15]/a").displayed?}
            
            #不定期なnewslatter対応
            if (driver.find_elements(:id, 'modal-content-111').size != 0) then
                driver.execute_script('document.getElementsByClassName("action-close")[0].click()')
            end

            driver.find_element(:xpath => "//*[@id='continent-list']/div[4]/ul/li[15]/a").click
        end

        sleep 2
        #フッターが表示されるまでまつ 最大で10秒だよね？
        wait.until { driver.find_element(:class => "footer-menu").displayed?}

        #sleep入れないと今のところブランドページにジャンプしてくれない...
        sleep 2
        #ホームに到着後はもう一度ブランドのページヘ移動
        driver.get(brand_home_url)
        sleep 2
        driver.execute_script('document.getElementById("popup-geoip-misfits-continue-close-advice").click()')
        sleep 2
        
        doc = Nokogiri::HTML.parse(driver.page_source)
        
        #商品ボックスの初期値は2
        newest_number_product_wrapper = doc.css('.wrapper').size
        #初期値=0代入しておく
        last_number_product_wrapper = 0
        
        #div class="wrapper"の数が変わらなくなるまで処理を繰り返す
        until (last_number_product_wrapper == newest_number_product_wrapper) do
            #puts "until内部"
            #最新のwrapperクラスの数をlast_number_product_wrapperに代入
            last_number_product_wrapper = newest_number_product_wrapper

            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            sleep 2

            #スクロールした直後のwrapperクラスの数を代入
            doc = Nokogiri::HTML.parse(driver.page_source)
            newest_number_product_wrapper = doc.css('.wrapper').size
            
        end

        #4桁以上なら商品の桁数桁数調整
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        products = doc.css('.product-item')
        #puts products.size
        products.each do |product|
        product_price = product.css('.price-wrapper').inner_text
            if product_price.include?(search_price) then
                #商品価格
                #puts product_price.strip
                #商品名
                #puts product.css(".product-item-link").text.strip
                #画像リンク
                puts product.css('a').attribute("href").value
            end
        end
    end
end