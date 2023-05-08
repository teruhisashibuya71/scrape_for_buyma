#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module Tessabit

    def tessabit_onetime_crawl_selenium(doc, search_price)
        products = doc.css('.contfoto')
        products.each do |product|
            item_price = product.css('.saldi').inner_text
            if (item_price.include?(search_price)) then
                #puts item_price 
                #puts product_name = product.css('h5').inner_text
                puts link_url = "http://specialshop.atelier98.net/it/" + product.css('a').attribute("href").value
            end
        end
    end

    def tessabit_crawl_selenium(brand_home_url, search_price)
        #事前準備 ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        #クリックメソッドが処理中にある場合は安定稼働のためにウインドウをリサイズ
        driver.manage.window.resize_to(1300,1000)

        #価格を免税に調整 小数点以下は先所して文字列に戻す
        #duty_free_price = search_price.to_i / 1.22
        #duty_free_price = duty_free_price.floor
        #duty_free_price = duty_free_price.to_s
        #商品価格が4桁の場合は 2桁目に「.」を追加
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #ログイン処理
        driver.get("http://specialshop.atelier98.net/it/register.html")
        wait.until { driver.find_element(:id, 'loginutente').displayed? }
        el = driver.find_element(:xpath, '/html/body/div[2]/div[3]/div/div/div/div/div[1]/div[2]/form/input[3]')
        el.send_keys('lshibuya.ts@gmail.com')
        el = driver.find_element(:xpath, '/html/body/div[2]/div[3]/div/div/div/div/div[1]/div[2]/form/div[1]/input')
        el.send_keys('110028531')
        el = driver.find_element(:xpath, '/html/body/div[2]/div[3]/div/div/div/div/div[1]/div[2]/form/input[5]')
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
            tessabit_onetime_crawl_selenium(doc, search_price)
        else
            clowled_urls = []
            #今のページURLが配列の中になければ処理を繰り返す
            until (clowled_urls.include?(driver.current_url)) do #偽なら繰り返し
                #商品が表示されるまで待つ
                wait.until { driver.find_element(:id, 'catalogogenint').displayed? }
                
                #クローリングして配列に加える
                doc = Nokogiri::HTML.parse(driver.page_source)
                tessabit_onetime_crawl_selenium(doc, search_price)
                clowled_urls.push(driver.current_url)

                #もしクリックできるなら
                if (doc.at_css('.bloccopagine').css(".nolink:nth-last-child(2)").css('li').attribute('class').nil?) then
                    break
                else
                    #後ろから2番目の「>」のURLを取得して次ページに移動
                    next_link = doc.at_css('.bloccopagine').css(".nolink:nth-last-child(2)").attribute("href").value
                    next_page_url = "http://specialshop.atelier98.net/it/" + next_link
                    driver.get(next_page_url)
                end
            end
        end
    end
end