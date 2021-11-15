require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#✓後でページ送り機能を念のため付ける
module Monti

    def monti_one_time_crawl(doc, search_price)
        products = doc.css('.product')
        products.each do |product|
        product_price = product.css('.price').inner_text
            if product_price.include?(search_price) then
                #商品価格
                #puts product_price.strip
                #商品名
                #puts product.css(".name").text.strip
                #画像リンク
                puts "https://www.montiboutique.com/" + product.css('a').attribute("href").value
            end
        end
    end


    def monti_crawl_selenium(brand_home_url, search_price, target_category)
        
        #ヘッドレス
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        #ノーマル
        #driver = Selenium::WebDriver.for :chrome
        driver.manage.window.resize_to(1300,1000)
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)

        #アクセス開始
        driver.get(brand_home_url)
        
        wait.until { driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").displayed? }
        country = driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").text

        sleep 2

        #freeShippingや各種プロモウインドウが表示されたら削除
        if (driver.find_elements(:id, 'brg-modal-content').size != 0) then
            #画面の端っこをクリックしてウインドウ削除
            driver.action.move_by(10, 10).click.perform
        end

        if (!country.include?("ITALY")) then
            #クッキーウインドウのクリック
            sleep 1
            driver.execute_script('document.getElementsByClassName("accept")[0].click()')
            sleep  1
    
            #発送先Japanをクリック sleep入れないとleft要素見つからない
            wait.until { driver.find_element(:class => "links").displayed? }
            driver.find_element(:xpath, '/html/body/footer/section/ul[4]/li[3]/a/span').click
            #sleep 1
    

            #freeShippingや各種プロモウインドウの表示を待つ必要あり
            sleep 4
            if (driver.find_elements(:id, 'brg-modal-content').size != 0) then
                #画面の端っこをクリックしてウインドウ削除
                driver.action.move_by(10, 10).click.perform
            end

            #発送地域が全て表示されるまで待ってからeuropeをクリック
            wait.until { driver.find_element(:class => "left").displayed? }
            driver.find_element(:xpath, '/html/body/div[3]/form/div/div[1]/h5[1]').click
            #仕方がないのでsleepで対応
            sleep 1
    
            #国の名前が表示されるまで待ってitalyをクリック
            wait.until { driver.find_element(:id => 'zona-1').enabled? }
            driver.find_element(:xpath, '//*[@id="zona-1"]/ul/li[27]/label').click
    
            #→€クリック
            driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/div[1]/ul/li[4]/label').click
            #→Englishをクリック
            driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/div[2]/ul/li[2]/label').click
    
            #saveボタンの表示を待ってからクリック
            wait.until { driver.find_element(:xpath => '/html/body/div[3]/form/div/div[2]/button').displayed? }
            driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/button').click
        end
    
        sleep 2
    
        wait.until { driver.find_element(:class => "content").displayed?}
        #ブランドブランドホームへもう一度アクセス
        driver.get(brand_home_url)
    
        sleep 2
    
        #カテゴリー別アクセスの処理も後で作成
    
        #4桁以上なら商品の桁数桁数調整
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
    
        doc = Nokogiri::HTML.parse(driver.page_source)
        
        #1回クローリングする
        monti_one_time_crawl(doc, search_price)
        #pagerが存在しているなら繰り返し処理へ
        if (!doc.css('.pager').empty?) then
            
            #css('.next')の中身が空になるまで何度も処理を実行
            until (doc.css('.next').empty?) do
                
                #nextボタンをクリック
                wait.until { driver.find_element(:class => "next").displayed?}
                driver.find_element(:class, "next").click
                sleep 0.5
                
                #次のページの商品リスト欄が表示されるまでまつ
                wait.until { driver.find_element(:class => "products-list").displayed?}
                #ページソース取得
                doc = Nokogiri::HTML.parse(driver.page_source)                
                #クローリングする
                monti_one_time_crawl(doc, search_price)
            end
        end
    end
end
