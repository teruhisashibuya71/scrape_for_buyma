require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#✓後でページ送り機能を念のため付ける
module Blondie

    #一番下まで移動してページソースを返すメソッド
    def blondie_scroll_bottom(brand_home_url)
        #ヘッドレスは2行+options
        #options = Selenium::WebDriver::Chrome::Options.new
        #options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome  #, options: options
        wait = Selenium::WebDriver::Wait.new(:timeout => 5) # second
        #ブランドページにアクセス
        driver.get(brand_home_url)
        #商品欄が表示されるまで待つ
        wait.until { driver.find_element(:xpath => '//*[@id="maincontent"]/div[4]').displayed? }

        #スクロールスクロール画面下までスクロールする PRADAが多いので12回くらい
        12.times do # 一度だけはスクロールできないかもしれないので10回繰り返す
            sleep(1)
            driver.execute_script('window.scroll(0,1000000);') # 画面下までスクロールを実行
        end
        return driver
    end

    #カテゴリが複雑すぎるのでカテゴライズメソッドは用意しない

    #seleniumによる docを作るためのメソッド
    def blondie_make_doc_bySelenium(driver)
        page_source_include_bottom_layer = driver #.page_source #最下層までのページソースを取得
        return page_source_include_bottom_layer
    end

    #クロールするメソッド
    def blondie_crawl(brand_home_url, search_price)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #最下層までのソースを作る
        driver = blondie_scroll_bottom(brand_home_url)
        page_source_include_bottom_layer = blondie_make_doc_bySelenium(driver)


        products = page_source_include_bottom_layer.find_elements(:class, "product-item")
        products.each do |product|
            #puts product.to_s productの中身を出力することは不可能 find_elements使用して要素を縫い出すしかない
            price_array = product.find_elements(:class, "price-box")

            #soldoutでは無いものだけを対象に上方を抜き出すクローリングする
            if price_array.size == 1 then
                #item_price = product.find_elements(:class, "price").text
                #item_price = product.find_elements(:class, "price")
                item_price = product.find_element(:class_name, "price").text
                puts item_price.empty?
                pr_name = product.find_element(:class_name, "product-item-designer").text
                puts pr_name
                #item_name = product.find_elements(:tag_name, "h2").text
                #item_name = product.find_elements(:tag_name, "h2")
                #puts item_name.size
                #if item_price.include?(search_price) then
                #    puts item_price[0].text.strip
                #    puts product_name = product.find_element(:class, "truncate").text
                #    puts link_url = product.find_elements(:tag_name, "a")[0].attribute("href")
                #end
            end
        end
    end
end
