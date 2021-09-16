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
        
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)

        sleep 1
        
        #価格桁調整は必要無しのサイト

        #免税＆＆小数点切り捨て
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.floor.to_s

        #商品リストが表示されるまで待つ
        wait.until { driver.find_element(:class, 'center-2').displayed? }

        #初回クロールする
        doc = Nokogiri::HTML.parse(driver.page_source)
        spinnaker_onetime_crawl(duty_free_price, doc)
        
        #pagerがあるなら繰り返し処理へ
        if (doc.css('.pager').size != 0) then
            
            #ページ送り用の右矢印「>」 next-pageクラスがなくなるまでクロールする
            until (doc.css('.next-page').size == 0) do
                
                #最下層へ移動してからリンクをクリックして次のページに移動
                driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                driver.execute_script("window.scrollBy(document.body.scrollHeight, -400);")
                driver.find_element(:class, 'next-page').click

                sleep 1

                #商品商品表示領域が表示されるまで待つ
                wait.until { driver.find_element(:class, 'center-2').displayed? }

                #次のページのdocを取得してクロールしなおす
                doc = Nokogiri::HTML.parse(driver.page_source)
                spinnaker_onetime_crawl(duty_free_price, doc)

                sleep 2
            end
        end
    end
end