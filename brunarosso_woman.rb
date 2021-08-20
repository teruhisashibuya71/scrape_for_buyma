#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module BrunarossoWoman

    def brunarosso_onetime_crawl_selenium(doc, custom_price)
        products = doc.css('.ajax_block_product')
        products.each do |product|

            item_price = product.css('.price').inner_text
            if (item_price.include?(custom_price)) then
                puts item_price
                
                puts product_name = product.css('h5').inner_text
                
                puts link_url = product.css('.product_img_link').attribute("href").value
            end
        end
    end

    def brunarosso_crawl_selenium(brand_home_url, search_price, search_category)
    
        #ヘッドレスバージョン
        #options = Selenium::WebDriver::Chrome::Options.new
        #options.add_argument('--headless')
        #driver = Selenium::WebDriver.for :chrome, options: options
        #ノーマル
        driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.get(brand_home_url)
        
        #国設定用のmodal-windowを操作する
        #国設定用のドロップダウンが表示されるまで待つ→
        wait.until { driver.find_element(:id, 'shipping_country_id').displayed? }
        #ドロップダウンメニューをクリック
        driver.execute_script('document.getElementById("shipping_country_id").click()')
        #italyをクリック
        driver.find_element(:xpath, '//*[@id="shipping_country_id"]/option[106]').click
        #validateボタンをクリック
        driver.find_element(:xpath, '//*[@id="formShippingCountry"]/div[3]/button').click
        sleep 1
        
        #サイドバーが表示されるまで待つ
        wait.until { driver.find_element(:id, 'product-sidebar').displayed? }
            if search_category == "服" then
                driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[3]/a').click
            elsif search_category == "靴" then
                driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[4]/a').click
                
            elsif search_category == "バッグ" then
                driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[2]/a').click
                
            else
                driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[1]/a').click
            end
        
        sleep 1
        
        #商品一覧が表示されるまで待つ
        wait.until { driver.find_element(:class_name, 'product_list').displayed? }
        #画面下までスライド
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        
        #商品情報が全て表示されるまで待つ
        sleep 8
        #念の為wait処理も記述する記述記述しておく
        wait.until { driver.find_element(:class_name, 'price').displayed? }
        wait.until { driver.find_element(:tag_name, 'h5').displayed? }
        wait.until { driver.find_element(:class, 'product_img_link').displayed? }
        
        #docを取得
        doc = Nokogiri::HTML.parse(driver.page_source)
        
        #桁を削除する可能性があるので別の変数に代入
        custom_price = search_price
    
        #商品価格が4桁の場合は最初の桁を削除
        if custom_price.length >= 4 then
            custom_price = custom_price[1..-1] 
        end
    
        #初回クロール
        brunarosso_onetime_crawl_selenium(doc, custom_price)
        
        #繰り返し処理
        #page-natonがあるかどうか
        if (!doc.css('.product-pagination').empty?) then
            #css('.next')の中身が空になるまで何度も処理を実行
            until (doc.css('.next').empty?) do
                #nextボタンをクリック
                wait.until { driver.find_element(:class => "next").displayed?}
                puts driver.find_element(:class, "next").size #サイズ2のはず
                lower_pagenation = driver.find_element(:class, "next")[1]
                puts lower_pagenation[2]
                
                #driver.find_element(:class, "next")[1].click
                driver.find_element(:xpath, '//*[@id="center_column"]/div/div/div[2]/div[3]/ul/li[3]/a').click
                
                sleep 0.5
                
                puts "クリック完了で次のページへ"

                #次のページの商品リスト欄が表示されるまでまつ
                wait.until { driver.find_element(:class => "products-list").displayed?}
                driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                sleep 8
                #ページソース取得
                doc = Nokogiri::HTML.parse(driver.page_source)                
                #クローリングする
                brunarosso_onetime_crawl_selenium(doc, custom_price)
            end
        end
    end
end