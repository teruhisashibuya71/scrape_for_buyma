require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#✓後でページ送り機能を念のため付ける
module Monti

    def monti_one_time_crawl(doc, duty_free_price)
        products = doc.css('.product')
        products.each do |product|
        product_price = product.css('.price').inner_text
            if product_price.include?(duty_free_price) then
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
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        driver.manage.window.resize_to(1300,1000)
        wait = Selenium::WebDriver::Wait.new(:timeout => 20)
        driver.get(brand_home_url)
        
        #通常
        # driver = Selenium::WebDriver.for :chrome
        # wait = Selenium::WebDriver::Wait.new(timeout: 20)
        # driver.manage.window.resize_to(1300,1000)
        # driver.get(brand_home_url)

        #免税＆＆四捨五入
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.round.to_s

        #価格が4桁以上なら商品の桁数桁数調整
        if duty_free_price.length >= 4 then
            duty_free_price = duty_free_price.insert(1, ".")
        end
        
        #クッキーウインドウがあれば消去する elementsでidも使える
        if (driver.find_element(:class, 'CybotCookiebotDialogContentWrapper').size != 0) then
            driver.execute_script('document.getElementsByClassName("CybotCookiebotDialogBodyButton")[0].click()')
        end

        #freeShippingや各種プロモウインドウが表示されたら削除
        if (driver.find_elements(:id, 'brg-modal-content').size != 0) then
            #画面の端っこをクリックしてウインドウ削除
            driver.action.move_by(10, 10).click.perform
        end
        
        #フッターが表示されるまで待つ
        wait.until { driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").displayed? }
        country = driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").text

        #画面下まで移動
        #一番下まで移動
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        
        #発送国がイタリアになっていない場合は
        if (!country.include?("ITALY")) then
    
            #画面下の発送先Japanをクリック
            wait.until { driver.find_element(:class => "links").displayed? }
            driver.find_element(:xpath, '/html/body/footer/section/ul[4]/li[3]/a/span').click

            #画面右側の要素が表示されるのを待ってから　通貨部分の「€」をクリック
            wait.until { driver.find_element(:class => "right").displayed? }
            driver.find_element(:xpath, '/html/body/div[2]/form/div/div[2]/div[1]/ul/li[4]/label').click

            # #国の名前が表示されるまで待ってitalyをクリック
            # wait.until { driver.find_element(:id => 'zona-1').enabled? }
            # driver.find_element(:xpath, '//*[@id="zona-1"]/ul/li[27]/label').click
            
            #→Englishをクリック
            #driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/div[2]/ul/li[2]/label').click
    
            #saveボタンの表示を待ってからクリック
            wait.until { driver.find_element(:xpath => '/html/body/div[2]/form/div/div[2]/button').displayed? }
            driver.find_element(:xpath, '/html/body/div[2]/form/div/div[2]/button').click
            
            #wait.until { driver.find_element(:xpath => '/html/body/div[3]/form/div/div[2]/button').displayed? }
            #driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/button').click
        end
    
        #sleep 1
        #画面が再ロードされるのを待つ
        wait.until { driver.find_element(:class => "nations").displayed?}
        
        #wait.until { driver.find_element(:class => "content").displayed?}
        
        #ブランドブランドホームへもう一度アクセスして商品が表示されるのを待つ

        driver.get(brand_home_url)
        wait.until { driver.find_element(:class => "products").displayed?}
        doc = Nokogiri::HTML.parse(driver.page_source)
        
        #1回クローリングする
        monti_one_time_crawl(doc, duty_free_price)
        #pagerが存在しているなら繰り返し処理へ
        if (!doc.css('.pager').empty?) then
            
            #css('.next')の中身が空になるまで何度も処理を実行
            until (doc.css('.next').empty?) do
                #nextボタンをクリック
                wait.until { driver.find_element(:class => "next").displayed?}
                driver.find_element(:class, "next").click
                
                #次のページの商品リスト欄が表示されるまでまつ
                wait.until { driver.find_element(:class => "products-list").displayed?}
                
                #再度クローリング
                doc = Nokogiri::HTML.parse(driver.page_source)                
                monti_one_time_crawl(doc, duty_free_price)
            end
        end
    end
end
