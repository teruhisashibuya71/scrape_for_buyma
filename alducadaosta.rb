require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#カテゴリ分けは一旦保留

module Alducadaosta

    def alducadaosta_crawl_selenium(brand_home_url, search_price, category)
        
        #商品価格調整
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #ヘッドレスバージョン
        #options = Selenium::WebDriver::Chrome::Options.new
        #options.add_argument('--headless')
        #driver = Selenium::WebDriver.for :chrome, options: options    
        
        #クローム使う準備
        driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(:timeout => 8)
        driver.manage.window.resize_to(1500,1500)

        
        #対象のカテゴリ用のアクセスURLを作成
        if (category == "服") then
            #brand_home_url = brand_home_url + "/abbigliamento"
            
        elsif (category == "アクセ") then
            brand_home_url = brand_home_url + "/accessori"
        elsif (category == "バッグ") then
            brand_home_url = brand_home_url + "/borse"
        else #靴の時
            brand_home_url = brand_home_url + "/scarpe"
        end

        driver.get(brand_home_url)


        #商品が表示されるまで待つ
        wait.until { driver.find_elements(:class, 'products-list')[0].displayed? }

        if (driver.find_elements(:class, 'pagebuilder-list').size != 0)
            puts "alducadaostaには該当カテゴリの商品がありません"
        else
            
            #ゆっくり下までスクロール
            # last_height = driver.execute_script("return document.body.scrollHeight")
            # while true
            #     1.step(last_height, last_height / 3).each do |height|
            #         sleep(1)
            #         driver.execute_script("window.scrollTo(0, #{height})")
            #     end
            #     sleep(1)
            #     new_height = driver.execute_script("return document.body.scrollHeight")
            #     if new_height == last_height
            #         break
            #     end
            #     last_height = new_height
            # end


            #driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            #driver.execute_script("window.scrollTo(document.body.scrollHeight, -200);")

            sleep 3
            

            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            #driver.execute_script("window.scrollTo(document.body.scrollHeight, -200);")
            
            sleep 3

            driver.execute_script("window.scrollTo(document.body.scrollHeight, 0);")

            sleep 3

            last_height = driver.execute_script("return document.body.scrollHeight")
            while true
                1.step(last_height, last_height / 3).each do |height|
                    sleep(1)
                    driver.execute_script("window.scrollTo(0, #{height})")
                end
                sleep(1)
                new_height = driver.execute_script("return document.body.scrollHeight")
                if new_height == last_height
                    break
                end
                last_height = new_height
            end



            if (driver.find_elements(:id, 'brg-modal-content').size != 0) then
                #画面の左上のほうをクリックして逃げる
                driver.action.move_by(10, 10).click.perform
            end

            #プライバシーポリシーを回避
            if (driver.find_elements(:class, 'js-banner-policy').size != 0) then
                #画面の左上のほうをクリックして逃げる
                driver.execute_script('document.getElementsByClassName("js-close-privacy")[0].click()')
            end

            sleep 3


            driver.find_elements(:class, 'js-infinite-play')[0].click

            sleep 3
            
            # #LOADMOREボタンがあるかぎりクリックする
            # while (driver.find_elements(:class, 'js-infinite-play').size >= 1) do
            #     puts "whileのなか"
            #     #バナー対策
            #     if (driver.find_elements(:id, 'brg-modal-content').size != 0) then
            #         puts "バナークリック前"
            #         #driver.execute_script('document.getElementById("brg-modal-content").click()')
            #         #画面の左上のほうをクリックして逃げる
            #         driver.action.move_by(10, 10).click.perform
            #         puts "バナー対策クリックあと"
            #     end

            #     #driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            #     #puts "一番したへスクロール"
            #     #sleep 5

            #     #driver.execute_script("window.scrollTo(document.body.scrollHeight, -100);")
            #     #puts "少し上に戻った"
            #     #LOAD MOREボタンを押す

            #     sleep 5

            #     #cookie対策 全て許可してウインドウ消す
            #     if (driver.find_elements(:class, 'adroll_consent_notice').size != 0) then
            #         puts "クッキー対策"
            #         driver.execute_script('document.getElementsByClassName("adroll_consent_button")[0].click()')
            #     end


            #     sleep 5
                
            #     puts "LOADボタンクリックする"
            #     #driver.find_elements(:class, 'js-infinite-play')[0].click
            #     puts "LOADボタンクリックした"

            #     #ゆっくり下までスクロール
            #     last_height = driver.execute_script("return document.body.scrollHeight")
            #     while true
            #         1.step(last_height, last_height / 5).each do |height|
            #             sleep(2)
            #             driver.execute_script("window.scrollTo(0, #{height})")
            #         end
            #         sleep(2)
            #         new_height = driver.execute_script("return document.body.scrollHeight")
            #         if new_height == last_height
            #             break
            #         end
            #         last_height = new_height
            #     end
                
            # end

            

            #念の為商品が表示されるまで待つ処理をもう一回記述する
            #wait.until { driver.find_elements(:class, 'products-list')[0].displayed? }
                        
            sleep 4

            #一回クロールして終了
            # doc = Nokogiri::HTML.parse(driver.page_source)
            # products = doc.css('.product')
            # products.each do |product|
            # product_price = product.css('.product__price').inner_text
            # if product_price.include?(search_price) then
            #     #商品価格
            #     #puts product_price.strip
            #     #商品名
            #     #puts product.css(".product-item-link").text.strip
            #     #画像リンク
            #     puts "https://www.alducadaosta.com" + product.css('a').attribute("href").value
            # end
        #end
            
            
        end
    end
end