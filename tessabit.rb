require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'



#PaginationStyled-sc-1aduclw-18 disRaXがれば繰り返し処理へ
#最下層までスクロール sleep 
#navButton-icon-xu0 icon-root-1sI first がclickableなうちは処理を繰り返す

module Tessabit
    
    def tessabit_one_time_crawl(doc, search_price)
        products = doc.css('.izHQXc')
        products.each do |product|
        product_price = product.css('.kdAeOb').inner_text
            if product_price.include?(search_price) then
                #商品価格
                #puts product_price.strip
                #商品名
                #puts product.css(".name").text.strip
                #画像リンク
                puts "https://www.tessabit.com" + product.css('a').attribute("href").value
            end
        end
    end

    def tessabit_crawl_selenium(brand_home_url, search_price)
    
        #ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        #ノーマル
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.manage.window.resize_to(1500,1000)

        #商品価格調整
        #商品価格の調整はコンマ
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #スタート
        driver.get(brand_home_url)

        sleep 8

        #商品が表示されるまで待つ
        wait.until { driver.find_element(:class, 'Section-sc-1aduclw-1').displayed? }
        
        
        #初回クロール開始
        doc = Nokogiri::HTML.parse(driver.page_source)
        products = doc.css('.izHQXc')

        if  (products.size > 0) then
            tessabit_one_time_crawl(doc, search_price)
            #ページネーション PaginationStyled-sc-1aduclw-18クラスあるなら繰り返し処理へ
            if (doc.css('.PaginationStyled-sc-1aduclw-18').size > 0) then
                
                #リンクの最後のページまで飛ぶボタンがクリックできる限りは処理を繰り返す
                while (driver.find_elements(:class, 'PaginationStyled-sc-1aduclw-18')[0].find_elements(:class, 'navButton-root-2Fj').last.enabled?) do
                    
                    #クッキーウィンンドウが表示されていたらクリックする
                    if (driver.find_elements(:class, 'iubenda-cs-container').size != 0) then
                        driver.execute_script('document.getElementsByClassName("iubenda-cs-accept-btn")[0].click()')
                    end

                    sleep 1

                    #チャットウインドウが表示されていたらクリックして閉じる
                    if (driver.find_elements(:class, 'sc-1q7kfbv-0').size != 0) then
                        driver.execute_script('document.getElementsByClassName("sc-htpNat d697ci-0")[0].click()')
                    end

                    sleep 1

                    #ジャパンサイトのバナー表示があるならクリックする
                    if (driver.find_elements(:class, 'Root-sc-1x8nxv0-0').size != 0) then
                        driver.execute_script('document.getElementsByClassName("Dismiss-sc-1x8nxv0-4")[0].click()')
                    end
                    
                    #ページの一番下まで移動
                    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

                    sleep 1
                    
                    #次のページへ移動

                    driver.find_elements(:class, 'PaginationStyled-sc-1aduclw-18')[0].find_elements(:class, 'navButton-root-2Fj')[2].click

                    sleep 6

                    #商品コンテンツが表示されるまで待つ
                    wait.until { driver.find_element(:class, 'Section-sc-1aduclw-1').displayed? }
                    
                    #再度docを取得する
                    doc = Nokogiri::HTML.parse(driver.page_source)

                    #もう一度クロール
                    tessabit_one_time_crawl(doc, search_price)
                end
            end
        else
            puts "tessabitには該当ブランドの商品がありません"
        end
    end
end