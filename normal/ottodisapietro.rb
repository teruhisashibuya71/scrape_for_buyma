#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module Ottodisapietro

    def ottodisapietro_crawl_selenium(brand_home_url, search_price)
        
        #ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        
        #クローム使う準備
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(:timeout => 8)
        driver.manage.window.resize_to(1500,1000)
        driver.get(brand_home_url)
        
        #商品リストが表示されるまでまつ
        if (driver.find_elements(:class, 'CollectionInner__Products').size != 0) then
        
            #一番↓までスクロール
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

            #labelsを参考にして商品の数が変わらなくならまでスライドを繰り返す sleep4秒

            #LOADMOREボタンが1つも無い時のための分岐 無いなら繰り返し処理じたいに入らない
            if (driver.find_element(:id, 'infinite-scroll-load-more').displayed?) then
                #LOADMOREボタンがhiddendになるまでくりかえす
                while (true) do
                    #ボタンクリック
                    driver.find_element(:id, 'infinite-scroll-load-more').click
                    sleep 1
                    #一番下までスクロール
                    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                    sleep 1
                    #LOADMOREボタンは見つからなくなったら繰り返し処理を抜ける
                    if (!driver.find_element(:id, 'infinite-scroll-load-more').displayed?) then
                        break
                    end
                end
            end
        
            sleep 1
    
            doc = Nokogiri::HTML.parse(driver.page_source)
            products = doc.css('.ProductItem')
            #puts doc.css('.productItem').size 139でOK

            #商品価格の調整はドット
            if search_price.length >= 4 then
                search_price = search_price.insert(1, ".")
            end
            
            if (products.size == 0)
                puts "ottodisapietroは該当ブランドの商品が現在ありません"
            else
                products.each do |product|
                    product_price = product.css('.product-item__price').inner_text
                    #puts product.css('.product-item__link').attribute("href").value
                    if (product_price.include?(search_price)) then
                        #商品価格
                        #puts product_price.strip
                        #商品名
                        #puts product.css('.product-item-title').text.strip
                        #画像リンク
                        puts product.css('.ProductItem__Wrapper').attribute("href").value
                    end
                end
            end
        end
    end
end

