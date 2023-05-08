#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module AngeloMinetti

    def angelo_onetime_crawl_selenium(doc, duty_free_price)
        products = doc.css('.contfoto')
        products.each do |product|
            item_price = product.css('.saldi').inner_text
            if (item_price.include?(duty_free_price)) then
                #puts item_price 
                #puts product_name = product.css('h5').inner_text
                puts link_url = "https://www.minettiangeloonline.com/it/" + product.css('a').attribute("href").value
            end
        end
    end

    def angelo_crawl_selenium(brand_home_url, search_price)
        #事前準備 ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        #クリックメソッドが処理中にある場合は安定稼働のためにウインドウをリサイズ
        driver.manage.window.resize_to(1300,1000)

        #価格を免税に調整 小数点以下は先所して文字列に戻す
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.floor
        duty_free_price = duty_free_price.to_s
        #商品価格が4桁の場合は 2桁目に「.」を追加
        if duty_free_price.length >= 4 then
            duty_free_price = duty_free_price.insert(1, ".")
        end

        #ログイン処理
        driver.get("https://www.minettiangeloonline.com/it/register.html")
        wait.until { driver.find_element(:id, 'loginutente').displayed? }
        el = driver.find_element(:xpath, '//*[@id="loginutente"]/div/div/div[1]/div[2]/form/input[3]')
        el.send_keys('lshibuya.ts@gmail.com')
        el = driver.find_element(:xpath, '//*[@id="loginutente"]/div/div/div[1]/div[2]/form/input[4]')
        el.send_keys('b2bcartishibuya')
        el = driver.find_element(:xpath, '//*[@id="loginutente"]/div/div/div[1]/div[2]/form/input[6]')
        el.click        
        wait.until { driver.find_element(:xpath => '//*[@id="sticker"]').displayed?}        
        

        #対象ブランドの画面にアクセスしてdoc取得
        driver.get(brand_home_url)
        wait.until { driver.find_element(:id => 'catalogogen').displayed?}      
        doc = Nokogiri::HTML.parse(driver.page_source)

        #paginationがあるかどうかで処理を分岐クローリング回数を決める
        #paginate = driver.find_elements(:class => 'pagine')
        if (doc.css('.pagine').size <= 1) then
            #1回クローリングして終了
            angelo_onetime_crawl_selenium(doc, duty_free_price)
        else
            #pagination中の>のテキストを取得
            elem = doc.at_css('.bloccopagine .pagine:nth-last-child(2)').inner_text
            clowled_urls = []

            if (elem = "") then
                #後ろから2番目のpagineの中身が""でなくなるまでクローリング
                while (elem = "") do
                    #まずは1回クローリングする
                    angelo_onetime_crawl_selenium(doc, duty_free_price)
                    
                    #クロールしたurlは配列に加える
                    clowled_urls.push(driver.current_url)

                    #後ろから2番目のリンク取得して次のページに移動
                    target_link = doc.at_css('.bloccopagine .pagine:nth-last-child(2)').css('a').attribute("href").value
                    next_page_url = "https://www.minettiangeloonline.com/it/" + target_link
                    driver.get(next_page_url)
                    
                    #次のページのURLがクローズ済みURL配列の中にあるならクローリング処理は終了
                    if (clowled_urls.include?(driver.current_url)) then
                        break
                    end

                    #クロール済みのページでなければ再度クロールする
                    wait.until { driver.find_element(:id => 'catalogogen').displayed?}
                    doc = Nokogiri::HTML.parse(driver.page_source)
                    angelo_onetime_crawl_selenium(doc, duty_free_price)
                end
            end
        end
    end
end