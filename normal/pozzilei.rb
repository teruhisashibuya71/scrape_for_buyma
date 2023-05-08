#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module Pozzilei

    def pozzilei_onetime_crawl_selenium(doc, search_price)
        products = doc.css('.product-item')
        products.each do |product|
            #メンテナンス性を意識して対象の商品価格の方からドットやコンマを取り除く
            item_price = product.css('.product-item-price').attribute("span").inner_text.delete(".")
            if (item_price.include?(search_price)) then
                #puts item_price 
                #puts product_name = product.css('h5').inner_text
                puts product.css('a').attribute("href").value
            end
        end
    end

    def pozzilei_crawl_selenium(brand_home_url, search_price)
        
        #ヘッドレス
        # options = Selenium::WebDriver::Chrome::Options.new
        # options.add_argument('--headless')
        # driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        # wait = Selenium::WebDriver::Wait.new(timeout: 30)
        # driver.manage.window.resize_to(1800,1200)
        # driver.get(brand_home_url)

        #通常
        driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)

        #価格調整無し

        #画面がすべて読み込まれるまで待機
        wait.until { driver.execute_script("return document.readyState") == "complete" }
        
        #一番下に移動
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

        #クッキーウインドウがあれば消去する elementsでidも使える
        if (driver.find_elements(:class, 'iubenda-cs-container').size != 0) then
            driver.execute_script('document.getElementsByClassName("iubenda-cs-btn-primary")[1].click()')
        end

        #クーポンウインドウがあるなら削除する
        if (driver.find_elements(:id, 'popup-newsletter-form').size != 0) then
            driver.execute_script('document.getElementsByClassName("close")[0].click()')
        end

        sleep 2

        #①.国選択欄をクリック
        footer_country = driver.find_elements(:css, '.footer-content .footer-menu li')
        footer_country[0].click

        # #クーポンウインドウがあるなら削除する
        # if (driver.find_elements(:id, 'popup-newsletter-form').size != 0) then
        #     driver.execute_script('document.getElementsByClassName("close")[0].click()')
        # end

        #国選択のモーダルウインドウが表示されるのを待つ
        wait.until { driver.find_element(:id => "countries-overlay").displayed? }

        #エリア「EUROPE」と「italy」それぞれの要素を取得しておく 
        link_text_europe = driver.find_elements(:css, '#countries-select .card:nth-child(4) .card-header h4 a') #EUROPEを取得

        # 出力結果 → EUROPE
        link_text_europe.each do |element|
            puts element.text
        end

        #クーポンウインドウがあるなら削除する
        if (driver.find_elements(:id, 'popup-newsletter-form').size != 0) then
            driver.execute_script('document.getElementsByClassName("close")[0].click()')
        end

        sleep 2


        #europeをクリック
        link_text_europe[0].click

        #----------------------------------------------------


        #モーダルが開くのを待つ
        sleep 2
        

        text_italy = driver.find_elements(:css, '#countries-select .card:nth-child(4) .collapse .card-body ul li:nth-child(25)')
        puts text_italy.size

        text_italy = driver.find_elements(:css, '#countries-select .card:nth-child(4) .collapse .card-body ul li:nth-child(25) a')
        puts text_italy.size

        #italyの旗を取得
        text_italy = driver.find_elements(:css, '#countries-select .card:nth-child(4) #continent-4 .card-body ul li:nth-child(25) .flag')
        
        #size 0なので取得できていない
        #text_italy = driver.find_elements(:css, '#countries-select .card:nth-child(4) #continent-4 .card-body ul li:nth-child(25) i')
        
        puts "旗.sizeは"
        puts text_italy.size #1結果は

        
        # text_italy.each do |linktext|
        #     text = linktext.text
        # puts text unless text.empty?
        # end

        # italyの旗をクリック
        text_italy[0].click

        #次ページ次ページはここから
        #画面がすべて読み込まれるまで待機
        wait.until { driver.execute_script("return document.readyState") == "complete" }


        #クッキーウインドウがあれば消去する elementsでidも使える
        if (driver.find_elements(:class, 'iubenda-cs-container').size != 0) then
            driver.execute_script('document.getElementsByClassName("iubenda-cs-btn-primary")[1].click()')
        end

        #クーポンウインドウが表示されているなら削除する
        if (driver.find_elements(:id, 'popup-newsletter-form').size != 0) then
            driver.execute_script('document.getElementsByClassName("close")[0].click()')
        end

        #モーダル上のリンクテキスト「EUROPE」をクリックする
        driver.execute_script("arguments[0].click();", link_text_europe[0])


        #モーダルその2が表示された後、国一覧から「italy」をクリック 25番目 → 24index
        sleep 1.5
        #wait.until { driver.find_elements(:css => '#countries-select .card:nth-last-child(3) #continent-4').displayed? }
        #puts driver.find_elements(:css, '#countries-select .card:nth-child(3) .collapse .card-body ul li').size
        #puts driver.find_elements(:css, '#countries-select .card:nth-child(3) .collapse .card-body ul li').size
        
        #クーポンウインドウが表示されているなら削除する
        if (driver.find_elements(:id, 'popup-newsletter-form').size != 0) then
            driver.execute_script('document.getElementsByClassName("close")[0].click()')
        end
        #driver.execute_script("arguments[0].click();", link_text_italy[24])

        #商品が表示されるまで待つ
        wait.until { driver.find_element(:class => "catalogue-container").displayed? }

        #初回クローリング
        doc = Nokogiri::HTML.parse(driver.page_source)
        pozzilei_onetime_crawl_selenium(doc, search_price)
        
        #liの数が1個でない場合は繰り返し処理に入る
        if (doc.css('#pagination').css('li').size != 1) then
            #クローリングしたurlを記憶しておく空の配列を用意
            crawled_urls = []
            #最初の1ページ目のurlを代入
            crawled_urls.push(brand_home_url)
            #変数を作っておく
            next_page_url = ""  

            #最後のliのclass名がactiveでない場合はクローリングを続ける
            while (doc.css('#pagination').css('li').last.attribute("class").to_s != "active") do
                #次ページのURLを取得してクロール済みでないかを確認する
                next_page_url = doc.css('#pagination').css('li').last.attribute('href')
                #次ページへアクセス
                driver.get(next_page_url)
                #商品が表示されるまで待つ
                wait.until { driver.find_elements(:class => "catalogue-container").displayed? }
                doc = Nokogiri::HTML.parse(driver.page_source)
                pozzilei_onetime_crawl_selenium(doc, search_price)
            end
        end
    end
end