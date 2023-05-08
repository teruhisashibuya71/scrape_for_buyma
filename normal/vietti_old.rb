require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#selenium
#免税表示/小数点は削除
#サイトアップデート後に改修済み 2023/01/07

module ViettiOld

    def vietti_onetime_crawl_selenium(doc, duty_free_price)
        products = doc.css('.product-preview')
        products.each do |product|
            item_price = product.css('.price').inner_text
            if (item_price.include?(duty_free_price)) then
                #puts item_price 
                #puts product_name = product.css('h5').inner_text
                puts link_url = product.css('a').attribute("href").value
            end
        end
    end

    def vietti_crawl_selenium(brand_home_url, search_price)
        #事前準備 ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        wait = Selenium::WebDriver::Wait.new(timeout: 20)
        driver.manage.window.resize_to(1300,1000)

        #価格を免税に調整 小数点以下は削除して文字列に戻す
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.floor
        duty_free_price = duty_free_price.to_s

        #対象ブランドの画面にアクセスしてdoc取得
        driver.get(brand_home_url)
        #商品エリアが表示されるまで待つ
        wait.until { driver.find_element(:class, 'container-category-line').displayed? }

        ##container-category-lineの縦幅で商品の有無を判断する
        if (200 < driver.find_element(:class, "container-category-line").size.height) then
            #商品表示エリアの大きさが十分にある場合はクローリングする
            doc = Nokogiri::HTML.parse(driver.page_source)
            #初回クローリング
            vietti_onetime_crawl_selenium(doc, duty_free_price)

            #繰り返し用部品の用意
            clowled_urls = []  
            clowled_urls.push(driver.current_url)

            #次のページに移動するボタンをクリック 商品が表示されるまで待機
            driver.find_elements(:class, 'btn-next')[0].click
            sleep 1
            
            #商品エリアが表示されるまで待つ
            wait.until { driver.find_element(:class, 'container-category-line').displayed? }

            #配列に重複するURLが無ければクロールを繰り返す until 条件がfalseの場合 → 繰り返し
            until (clowled_urls.include?(driver.current_url) or (driver.find_element(:class, "container-category-line").size.height < 200)) do
                doc = Nokogiri::HTML.parse(driver.page_source)
                vietti_onetime_crawl_selenium(doc, duty_free_price)
                #クロールしたurlは配列に加える
                clowled_urls.push(driver.current_url)
                #次ページのリンクをクリックする
                el = driver.find_elements(:class, 'btn-next')[0]
                el.click
                sleep 1
                wait.until { driver.find_element(:class, 'container-category-line').displayed? }
            end
        end
    end
end