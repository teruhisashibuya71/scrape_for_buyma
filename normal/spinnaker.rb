#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'


#たまにエラーでるので注意
#no such element: Unable to locate element: {"method":"css selector","selector":".next\\-page"}
module Spinnaker

    def spinnaker_onetime_crawl(search_price, doc)
        doc.css(".item-box").each do |product|
            #商品価格を取得する
            item_price = product.css(".prices").inner_text
            #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
            if item_price.include?(search_price) then
                #商品価格 商品名 画像リンク を取得する
                #puts item_price
                #puts product.css(".prices").inner_text
                puts product_url = "https://www.spinnakerboutique.it" + product.css(".picture").css('a').attribute("href").value
            end
        end
    end

    def spinnnaker_crawl_selenium(brand_home_url, search_price)
        
        #ヘッドレス
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)

        sleep 1
        
        #価格桁調整は「.」
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #商品リストが表示されるまで待つ
        wait.until { driver.find_element(:class, 'page--list').displayed? }
        
        #まずは一番下まで移動して少し戻る
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        driver.execute_script("window.scrollBy(document.body.scrollHeight, -400);")
        
        #送りボタンが1つも無い時のための分岐 無いなら繰り返し処理じたいに入らない
        if (driver.find_elements(:class, 'js-infinite-play').size != 0)  then
            #ボタンがなくなるまで繰り返す
            while (true) do
                #送りボタンクリック
                driver.find_elements(:class, 'js-infinite-play')[0].click

                sleep 3
                #一番下までスクロール
                driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                driver.execute_script("window.scrollBy(document.body.scrollHeight, -400);")
                sleep 1
                #LOADMOREボタンは見つからなくなったら繰り返し処理を抜ける
                if (driver.find_elements(:class, 'js-infinite-play').size == 0 ) then
                    break
                end
            end
        end

        sleep 1

        doc = Nokogiri::HTML.parse(driver.page_source)
        products = doc.css('.product')

        #商品価格の調整はドット
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
        
        if (products.size == 0)
            puts "spinnakerには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                product_price = product.css('.product__price').inner_text
                if (product_price.include?(search_price)) then
                    #商品価格
                    #puts product_price.strip
                    #商品名
                    #puts product.css('.product-item-title').text.strip
                    #画像リンク
                    puts "https://www.spinnakerboutique.com/" + product.css('.js-gtm-product-click').attribute("href").value
                end
            end
        end

        

    end
end