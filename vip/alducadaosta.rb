require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#カテゴリ分けは一旦保留
#完成
module Alducadaosta

    def alducadaosta_crawl_selenium(brand_home_url, search_price, category)
        
        #商品価格調整
        #価格が微妙に低い・高いケースがあるため、1ユーロ安い変数lower_serch_priceを作成する 一度数字にして1を引く その後文字列に戻す
        lower_search_price = search_price.to_i - 1
        lower_search_price = lower_search_price.to_s
        higher_search_price = search_price.to_i + 1
        higher_search_price = higher_search_price.to_s

        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
            if 4 <= lower_search_price.length then
                lower_search_price = lower_search_price.insert(1, ".")
            end
            if 4 <= higher_search_price.length then
                higher_search_price = higher_search_price.insert(1, ".")
            end
        end

        #ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        #driver = Selenium::WebDriver.for :chrome, options: options
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        
        #ノーマル
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(:timeout => 8)
        driver.manage.window.resize_to(1500,1000)

        #対象のカテゴリ用のアクセスURLを作成
        if (category == "服") then
            brand_home_url = brand_home_url + "/abbigliamento"  
        elsif (category == "アクセ") then
            brand_home_url = brand_home_url + "/accessori"
        elsif (category == "バッグ") then
            brand_home_url = brand_home_url + "/borse"
        else #靴の時
            brand_home_url = brand_home_url + "/scarpe"
        end

        driver.get(brand_home_url)

        sleep 2

        #商品があるならクローリングへ
        if (driver.find_elements(:class, 'products-list').size != 0) then
            #商品が表示されるまで待つ
            wait.until { driver.find_elements(:class, 'products-list')[0].displayed? }
            
            #クロール動作へ
            #ロードボタンがあるなら繰り返し処理へ 無いなら1回クロールして終了
            if (driver.find_elements(:class, 'js-infinite-play').size >= 1) then
                while (true) do 
                    #一番下まで移動 して一番上まで戻る
                    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                    sleep 3
                    driver.execute_script("window.scrollTo(document.body.scrollHeight, 0);")
                    sleep 3
    
                    #一番上から少しずつ下へ
                    last_height = driver.execute_script("return document.body.scrollHeight")
                    while true
                        1.step(last_height, last_height / 4).each do |height|
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
        
                    #ちょっと上に戻るだけでなぜかかなり戻る ギリギリボタンは押せるでとりあえずOK
                    driver.execute_script("window.scrollTo(document.body.scrollHeight, -10);")
                    #LOADMOREボタン押す
                    driver.find_elements(:class, 'js-infinite-play')[0].click
        
                    sleep 3

                    #docを再度取得 ボタン無いならbreakして処理を抜ける
                    doc = Nokogiri::HTML.parse(driver.page_source)

                    if (doc.css('.js-infinite-play').size == 0) then
                        break
                    end
                end #whileのend

                #クロールして終了
                doc = Nokogiri::HTML.parse(driver.page_source)
                products = doc.css('.product')
                products.each do |product|
                    product_price = product.css('.product__price').inner_text
                    #if product_price.include?(search_price) then
                    if (product_price.include?(search_price) || product_price.include?(lower_search_price) || product_price.include?(higher_search_price)) then
                        #商品価格
                        #puts product_price.strip
                        #商品名
                        #puts product.css(".product-item-link").text.strip
                        #画像リンク
                        puts "https://www.alducadaosta.com" + product.css('a').attribute("href").value
                    end
                end

            else
                #クロールして終了
                doc = Nokogiri::HTML.parse(driver.page_source)
                products = doc.css('.product')
                products.each do |product|
                    product_price = product.css('.product__price').inner_text
                    if product_price.include?(search_price) then
                        #商品価格
                        #puts product_price.strip
                        #商品名
                        #puts product.css(".product-item-link").text.strip
                        #画像リンク
                        puts "https://www.alducadaosta.com" + product.css('a').attribute("href").value
                    end
                end
            end    
        else
            puts "alducadaostaには該当カテゴリの商品がありません"
        end
    end
end