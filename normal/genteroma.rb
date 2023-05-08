#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module Genteroma
    
    def gente_crawl_selenium(brand_home_url, search_price)
        
        #ヘッドレス
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        
        #driver = Selenium::WebDriver.for :chrome
        driver.manage.window.resize_to(1300,1000)
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.get(brand_home_url)
        
        sleep 1
        #クッキーウィンドウを処理  ボタンあるならクリックする
        if driver.find_elements(:class, 'iubenda-cs-accept-btn').size != 0 then
            driver.execute_script('document.getElementsByClassName("iubenda-cs-accept-btn")[0].click()')
        end
    
        sleep 1
        
        #商品一覧が表示されるまで待つ
        wait.until { driver.find_element(:id, 'maincontent').displayed? }
        
        sleep 1
        
        #下までスクロールして少し戻る
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        driver.execute_script("window.scrollBy(document.body.scrollHeight, -400);")
        
        sleep 1
        
        #LOADボタンが1つも無い時のための分岐 無いなら繰り返し処理じたいに入らない
        if driver.find_element(:class, 'jsLoadMoreProducts').displayed? then
            #LOADMOREボタンがhiddendになるまでくりかえす
        
            while (true) do
                #LOADボタンをクリックする前にバナーの表示チェック
                if driver.find_elements(:class, 'popup-content').size != 0 then
                #if driver.find_elements(:class, 'popup-content')[0].displayed? then
                    driver.execute_script('document.getElementsByClassName("mfp-close")[0].click()')
                end
    
                #LOADボタンエリアをクリック
                driver.find_element(:class, 'jsLoadMoreProducts').click
                
                sleep 1
    
                #一番下までサイドスクロール
                driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                driver.execute_script("window.scrollBy(document.body.scrollHeight, -400);")
                
                sleep 1
                
                #LOADMOREボタンが見つからなくなったら繰り返し処理を抜ける                
                if (!driver.find_element(:class, 'jsLoadMoreProducts').displayed?) then
                    break
                end
            end
    
        end
        
        sleep 1
        
        #docを取得
        doc = Nokogiri::HTML.parse(driver.page_source)
        products = doc.css('.product-item')
        #商品桁数の調整はコンマ
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
        
        if (products.size == 0)
            puts "genteromaには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                product_price = product.css('.price-box').inner_text
                if (product_price.include?(search_price)) then
                    #puts product_price.strip
                    #puts product.css('.product-item-title').text.strip
                    puts product.css('.product-item-info').css('a').attribute("href").value
                end
            end
        end
    end
end

