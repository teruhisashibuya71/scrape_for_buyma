require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module Plline

    def plline_onetime_crawl_selenium(doc, search_price)
        products = doc.css('.product')
        products.each do |product|
            item_price = product.css('.price').inner_text
            if (item_price.include?(search_price)) then
                puts item_price 
                
                puts product_name = product.css('h5').inner_text
                
                puts link_url = product.css('.product-overview-image').attribute("href")
            end
        end
    end


    def plline_crawl_selenium(brand_home_url, search_price)
    
        #ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        #ノーマル↓
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)
        
        sleep 1
        
        #商品一覧が表示されるまで待つ
        wait.until { driver.find_element(:id, 'filtered').displayed? }

        sleep 1

        #初回クロール
        doc = Nokogiri::HTML.parse(driver.page_source)
        plline_onetime_crawl_selenium(doc, search_price)
        
        
        #page-natonがあるかどうかで繰り返し処理
        if (!doc.css('.pagination').empty?) then
            
            #icon--chevron-left がなくなるまでクローリングする
            until (doc.css('.icon--chevron-right').size == 0) do

                #下に少しスクロールして次のページリンクボタンを押す準備
                driver.execute_script("window.scrollTo(0,300);")
                #ページ上のpaginationが表示されているのを確認
                wait.until { driver.find_element(:id, 'top-pagination').displayed? }
                
                #ページ移動リンクボタンの数を取得
                #inner_text_atags = doc.css('#top-pagination').css('.pagination__pages').css('a')
                
                #現在のページ番号を確認 
                current_page_number = doc.css('#top-pagination').css('.active').inner_text
                current_page_number_integer = current_page_number.to_i
                click_index = current_page_number_integer - 1

                #商品ページのリンクリストを全て取得
                page_tags = driver.find_element(:id, 'top-pagination').find_element(:class, 'pagination__pages').find_elements(:tag_name, 'a')
                
                #リンクリストの中からクリックするべきリンクをクリックする
                #クリックするのはcurrent_page_numberから1引いた値
                page_tags[click_index].click

                #次のページに飛んだら少し待つ
                sleep 2                

                #商品一覧が表示されるまで待つ
                wait.until { driver.find_element(:id, 'filtered').displayed? }
                
                #クロールリングを実行
                doc = Nokogiri::HTML.parse(driver.page_source)
                plline_onetime_crawl_selenium(doc, search_price)
                
            end
        end
    end
end