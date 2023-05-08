require 'rubygems'
require 'nokogiri'
require 'open-uri'

#selenium
#リンクのdisable属性の値を取得 disabledなら1回で終了
#リンクのdisable属性の値を取得 disabledでない場合は くりかえしする
#buttonをクリックして次のページへ
#buttonがdisabledの属性を持たない場合は処理を繰り返す
module WrongWeather

    def wrong_make_doc(brand_home_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(brand_home_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end    

    def wrong_onetime_crawl_selenium(doc, search_price, lower_search_price)
        products = doc.css('.mt-10 .gap-y-12 .items-center')
        products.each do |product|
            #セール価格のテキストが空か否かで処理を分ける
            if (product.css('.line-through').inner_text.empty?) then
                #定価商品の場合
                product_price = product.css('.font-light').inner_text
            else
                #セール商品の場合：定価を内包するクラス名が変わる
                product_price = product.css('.line-through').inner_text
            end
            
            #取得した商品価格とターゲットの価格が一致するならリンクを出力
            if ( (product_price.include?(search_price))||(product_price.include?(lower_search_price)) ) then
                puts "https://www.wrongweather.net" + product.css('a').attribute("href").value
            end
        end
    end

    def wrong_crawl_selenium(brand_home_url, search_price)
        
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

        #価格表示調整  微妙に安い価格になっているため1€引いた価格を用意しておく
        lower_search_price = search_price.to_i - 1
        lower_search_price = lower_search_price.to_s

        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
            lower_search_price = lower_search_price.insert(1, ".")
        end

        #メインエリアの表示が完了してからdocを作成
        wait.until { driver.find_element(:id => "__layout").displayed? }
        doc = Nokogiri::HTML.parse(driver.page_source)

        #次ページへ移動するリンクテキストが「disabled」属性値を「持っていない」場合は処理を繰り返す
        while (doc.css('.mt-10 .justify-between .justify-end').css('button').attribute('disabled').to_s != "disabled") do
            wrong_onetime_crawl_selenium(doc, search_price, lower_search_price)
            
            #ページネーションのある位置まで移動して後、少しだけ上にスクロール
            location_paginate = driver.find_elements(:css, '.mt-10 .justify-between .justify-end')
            driver.execute_script("arguments[0].scrollIntoView();", location_paginate[0])
            sleep 1
            driver.execute_script('window.scrollBy(0, -300)')
            next_link = driver.find_elements(:css, '.mt-10 .justify-between .justify-end button')
            
            #バナーを含め、ページの要素が完全に表示されるまで待つ
            wait.until { driver.execute_script("return document.readyState") == "complete" }

            if (driver.find_elements(:class, 'bhr-ip__b').size != 0) then
                driver.execute_script('document.getElementsByClassName("bhr-ip__c__close")[0].click()')
            end



            #次ページへのリンクをクリック
            next_link[0].click
            sleep 1

            #商品が表示されるまで待ち、docを詰め替える
            #wait.until { driver.find_element(:id => "__layout").displayed? }
            #puts driver.current_url
            doc = Nokogiri::HTML.parse(driver.page_source)
            #wrong_onetime_crawl_selenium(doc, search_price, lower_search_price)

        end

        #クーポンのウインドウが表示された場合は消す
        #element_exists = driver.execute_script('return document.getElementsByClassName("bhr-ip__b").length > 0')
        #if element_exists
        #doc = Nokogiri::HTML.parse(driver.page_source)
        #if (driver.find_elements(:class, 'bhr-ip__c__img').size != 0) then
        #if (driver.find_elements(:class, 'bhr-ip__b').size != 0) then
        #if (driver.find_elements(:class, 'ip-close-event').size != 0) then
        
        #バナーを含め、ページの要素が完全に表示されるまで待つ
        wait.until { driver.execute_script("return document.readyState") == "complete" }
        if (driver.find_elements(:class, 'bhr-ip__b').size != 0) then
            driver.execute_script('document.getElementsByClassName("bhr-ip__c__close")[0].click()')
        end

        #初回クローリング または disabled値があった場合の最終ページのクローリング
        wrong_onetime_crawl_selenium(doc, search_price, lower_search_price)
    end
end