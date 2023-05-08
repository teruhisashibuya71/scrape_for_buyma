#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#selenium
#為替調整
#免税
#日本円表示対応
#ヘッドレスにすると価格取得ができなくなる 原因不明

module Papini

    def papini_onetime_crawl(doc, duty_free_price, range_price_low, range_price_high)
        products = doc.css('.prodottoPreview')
        if (products.size == 0)
            puts "papiniには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #セール価格のテキストが空か否かで処理を分ける
                if (product.css('.prodottoDiscounted').inner_text.empty?) then
                    #定価の場合
                    product_price = product.css('.prodottoPrice').inner_text.delete(",").delete("￥").gsub(" ","").to_i
                else
                    #セール商品の場合
                    product_price = product.css('.prodottoDiscounted').inner_text.delete(",").delete("￥").gsub(" ","").to_i
                end

                #商品価格がレンジ内に収まる場合はリンクを出力
                if product_price.between?(range_price_low,range_price_high) then
                    #商品価格 商品名 画像リンク を取得する
                    #puts item_price
                    puts product.css(".prodottoName").inner_text
                    puts "https://www.papinistore.com" + product.css('a').attribute("href").value
                end
            end
        end
    end

    def papini_crawl_selenium(brand_home_url,search_price, currency)
        
        #ヘッドレス
        # options = Selenium::WebDriver::Chrome::Options.new
        # options.add_argument('--headless')
        # driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        # wait = Selenium::WebDriver::Wait.new(timeout: 20)
        # driver.manage.window.resize_to(1300,1000)
        # driver.get(brand_home_url)

        #通常
        driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 20)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)

        #為替調整
        adjusted_currency = currency - 0.5
        
        #日本円処理
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.round #.to_s
        japanese_yen_price = duty_free_price * adjusted_currency
        japanese_yen_price = japanese_yen_price.floor
        
        #検索対象価格のレンジを設定
        if (japanese_yen_price >= 100000) then 
            range_price_low = japanese_yen_price - 2500
            range_price_high = japanese_yen_price + 2500  
        else 
            range_price_low = japanese_yen_price - 1500
            range_price_high = japanese_yen_price + 1500
        end

        # puts range_price_low
        # puts range_price_high
        sleep 1

        #商品ブロックの表示完了してからdocを取得
        wait.until { driver.find_element(:class, 'aproduct_container').displayed? }
        doc = Nokogiri::HTML.parse(driver.page_source)

        sleep 10

        #繰り返し処理に必要となる基本的な変数を用意
        if (doc.css('.paginaz').size < 1) then
            #ページネーションがなければ1回クローリングして終了
            papini_onetime_crawl(doc, duty_free_price, range_price_low, range_price_high)
        else
            #繰り返し準備
            clowled_urls = []
            
            #現在のページのURLがクロール済みURL配列に無い→クローリングする
            until (clowled_urls.include?(driver.current_url)) do
                #まずはクローリング
                papini_onetime_crawl(doc, duty_free_price, range_price_low, range_price_high)
                #クロールしたurlは配列に加える
                clowled_urls.push(driver.current_url)

                #ページ送りの位置を取得する
                paginaz = driver.find_elements(:class, 'paginaz')
                # 要素までスクロールするスクリプトを実行する
                driver.execute_script("arguments[0].scrollIntoView();", paginaz[0])
                sleep 1
                driver.execute_script('window.scrollBy(0, -300)')
                
                #クーポンが画面に表示された場合は消す
                if (driver.find_elements(:class, 'hoverimage_opacityOut').size != 0) then
                    driver.execute_script('document.getElementsByClassName("popupClose")[0].click()')
                end

                #後ろから2番目の「>」をクリックしてページを移動
                spans = driver.find_elements(:css, '.paginaz span')
                second_last_span_tag = spans[-2]
                second_last_span_tag.click
                
                #次ページの商品が表示されるまで待ってからdocを生成
                wait.until { driver.find_element(:class, 'aproduct_container').displayed? }
                sleep 5
                doc = Nokogiri::HTML.parse(driver.page_source)
            end
        end
    end
end

