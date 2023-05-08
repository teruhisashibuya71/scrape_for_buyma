#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#セール価格確認だけいつかやること
module Dante5

    def dante5_crawl_selenium(brand_home_url, search_price, category)
        
        #ヘッドレス
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)

        #通常
        # driver = Selenium::WebDriver.for :chrome
        # wait = Selenium::WebDriver::Wait.new(timeout: 20)
        # driver.manage.window.resize_to(1300,1000)
        # driver.get(brand_home_url)
        
        #商品価格の調整はドット
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #クッキーウインドウがあれば消去する elementsでidも使える
        if (driver.find_element(:class, 'CybotCookiebotDialogContentWrapper').size != 0) then
            driver.execute_script('document.getElementsByClassName("CybotCookiebotDialogBodyButton")[0].click()')
        end

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

        #商品リストが表示されるまでまつ
        wait.until {driver.find_elements(:class, 'products--forpage')[0].displayed?} 
        
        #一番↓までスクロールして1ページ分くらい戻る
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        driver.execute_script("window.scrollBy(document.body.scrollHeight, -1000);")

        #LOADMORE(class=js-infinite-play)ボタンが1つも無い時のための分岐 無いなら繰り返し処理には入らない
        if (driver.find_elements(:class, 'js-infinite-play').size != 0) then
            #LOADMOREボタンが無くなるまで繰り返す
            while (true) do
                #ボタンクリック
                driver.find_elements(:class, 'js-infinite-play')[0].click
                sleep 2
                #一番下までスクロールして1ページ分くらい戻る
                driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                driver.execute_script("window.scrollBy(document.body.scrollHeight, -1000);")
                sleep 2
                #LOADMOREボタンが存在しない場合は処理を抜ける
                if (driver.find_elements(:class, 'js-infinite-play').size == 0) then
                    break
                end
            end
        end

        sleep 1

        doc = Nokogiri::HTML.parse(driver.page_source)
        products = doc.css('.product')
        
        if (products.size == 0)
            puts "dante5には対象カテゴリの商品が現在ありません"
        else
            products.each do |product|
                product_price = product.css('.product__price').inner_text
                #puts product.css('.product-item__link').attribute("href").value
                if (product_price.include?(search_price)) then
                    #商品価格
                    #puts product_price.strip
                    #商品名
                    #puts product.css('.product-item-title').text.strip
                    #画像リンク
                    puts "https://www.dante5.com/" + product.css('a').attribute("href").value
                end
            end
        end
    end
end

