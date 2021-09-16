#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#ヘッドレスバージョン

module Papini

    def papini_onetime_crawl(doc, duty_free_price)
        products = doc.css('.ajax_block_product')
        if (products.size == 0)
            puts "papiniには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #セール価格あっても取得可能
                product_price = product.css('.content_price').inner_text
                if (product_price.include?(duty_free_price)) then
                    #商品価格
                    #puts product_price.strip
                    #商品名
                    #puts product.css('.category').text.strip
                    #画像リンク
                    puts product.css('a').attribute("href").value
                end
            end
        end
    end

    def papini_crawl_selenium(brand_home_url,search_price)

        #ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        #ノーマル
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 20)
        driver.get(brand_home_url)

        sleep 8

        if (driver.find_element(:id, 'sb-nav-close').displayed?) then  #バナーが表示されているならクローズボタンをクリック
            driver.execute_script('document.getElementById("sb-nav-close").click()')
        end
        
        sleep 1
        
        #画面右上の価格表記をクリック #ITALY→EURをクリック
        driver.find_element(:xpath, '//*[@id="topbar"]/div/div/div/div/div[1]/div[2]/div[1]/a').click
        driver.find_element(:xpath, '//*[@id="topbar"]/div/div/div/div/div[1]/div[2]/div[2]/div/div[1]/ul/li[5]/span').click
        sleep 0.5
        driver.find_element(:xpath, '//*[@id="topbar"]/div/div/div/div/div[1]/div[2]/div[2]/div/div[2]/div[2]/div/ul/li').click
        
        #10秒待つ
        sleep 10

        #免税価格とドットでで価格の桁数調整
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.floor.to_s
        #4商品の桁数調整(免税version)
        if duty_free_price.length >= 4 then
            puts duty_free_price = duty_free_price.insert(1, ".")
        end

        #ここまでOK

        doc = Nokogiri::HTML.parse(driver.page_source)
        #puts doc.css('.ajax_block_product').size #13こ
        products = doc.css('.ajax_block_product')
        if (products.size == 0) then
            #もう少し待ってからクロール
            sleep 10
            doc = Nokogiri::HTML.parse(driver.page_source)
            #クロールする
            papini_onetime_crawl(doc, duty_free_price)
        else
            #商品ブランドが「moncler」表記ならOK そうでなければもう一度待つ 5秒
            if (products[0].css('manufacturer-name-product-list').inner_text.include?("MONCLER")) then
                #クロール開始
                #クロールする
                papini_onetime_crawl(doc, duty_free_price)
            else
                #もう一度待ってからクロール
                sleep 10
                doc = Nokogiri::HTML.parse(driver.page_source)
                #クロールする
                papini_onetime_crawl(doc, duty_free_price)
            end
        end
    end
end

