require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

# selenium
# 国の設定変更が必要
# 繰り返し条件 ページネーションの最後の要素のhrefが空欄になるまで
# 価格取得方法 同じクラス名で定価/セールを表示  最初に表示されるのが定価なのでat_cssで取得
# ヘッドレスにすると地域選択ボタンをクリックできない → 原因不明
module Grifo

    def grifo_onetime_crawl_selenium(doc, duty_free_price, higher_search_price)
        products = doc.css('.product-item-info')
        products.each do |product|
            #セール価格があっても 定価を内包するクラス名は 「price」で変わらない
            if (product.at_css('.price').inner_text.include?(duty_free_price) || product.at_css('.price').inner_text.include?(higher_search_price)) then
                puts product.css('a').attribute("href").value
            end
        end
    end

    def grifo_crawl_selenium(brand_home_url, search_price)
        
        #ヘッドレス
        # options = Selenium::WebDriver::Chrome::Options.new
        # options.add_argument('--headless')
        # driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        # wait = Selenium::WebDriver::Wait.new(timeout: 30)
        # driver.manage.window.resize_to(1800,1200)
        # driver.get(brand_home_url)

        #通常
        driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 30)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)

        #価格表示調整
        #①.免税する 小数点は切り捨ての模様 590 → 483.6€だが表示は → 483.00€
        #高いケースがあるため、1ユーロ安い変数lower_serch_priceを作成する 一度数字にして1を引く その後文字列に戻す
        higher_search_price = search_price.to_i + 1
        higher_search_price = higher_search_price.to_s

        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.floor.to_s

        #価格の文字列調整だけ最初に実行
        if duty_free_price.length >= 4 then
            duty_free_price = duty_free_price.insert(1, ".")
            higher_search_price = higher_search_price.insert(1, ".")
        end

        #クッキーウインドウがあれば消去する elementsでidも使える
        if (driver.find_elements(:id, 'iubenda-cs-banner').size != 0) then
            driver.execute_script('document.getElementsByClassName("iubenda-cs-accept-btn")[0].click()')
        end

        #地域ボタンの表示を待ってからクリック
        #wait.until { driver.find_element(:xpath => '/html/body/div[2]/header/div[3]/div/div[3]/a/i').displayed? }
        wait.until { driver.find_element(:xpath => '/html/body/div[2]/header/div[3]/div/div[3]').displayed? }
        driver.find_element(:xpath, '/html/body/div[2]/header/div[3]/div/div[3]/a/i').click

        #横からスライドしてくるウインドウの表示を待つ
        wait.until { driver.find_element(:class => 'modal-inner-wrap').displayed? }

        #国選択欄を押下
        country_button = driver.find_elements(:css, '.fields-container #prettydropdown-country_id ul .selected')
        driver.execute_script("arguments[0].click();", country_button[1])
        
        #「Italy」までウインドウをスクロール 105番目のli = 104番目 少し上にずらして103番目
        countries = driver.find_elements(:css, '.fields-container #prettydropdown-country_id ul li')
        driver.execute_script('arguments[0].scrollIntoView(true);', countries[103])

        #「Italy」をクリック
        driver.execute_script("arguments[0].click();", countries[104])

        sleep 1

        #confirmボタンを押下する
        confirm_button = driver.find_elements(:css, '.fields-container .actions-toolbar .primary')
        driver.execute_script("arguments[0].click();", confirm_button[1])

        #ページ送り部分を含むメインエリアが表示されるまで待つ
        wait.until { driver.find_element(:id => "layer-product-list").displayed? }

        #ページ送りのHTML要素が存在するなら繰り返し処理を実行
        if (driver.find_elements(:class, 'pages').size >= 1) then
            doc = Nokogiri::HTML.parse(driver.page_source)
            
            #最後のliタグがクラス名 = pages-item-next を所持している間は処理を繰り返す
            last_litag_element = doc.css('.pages-items').css('ul').css('li').last
            litag_class_name = last_litag_element.attribute("class").to_s
            litag_href_value = last_litag_element.css('a').attribute("href").value

            while (litag_class_name.include?("pages-item-next")) do
                grifo_onetime_crawl_selenium(doc, duty_free_price, higher_search_price)
                
                #ウインドウの一番下まで移動
                driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                #次ページのURLにアクセス
                driver.get(litag_href_value)
                #driver.find_elements(:css, '.pages-items ul li').last.click
                
                #商品が表示されるまで待ち、docを詰め替える
                wait.until { driver.find_element(:id => "layer-product-list").displayed? }
                doc = Nokogiri::HTML.parse(driver.page_source)

                last_litag_element = doc.css('.pages-items').css('ul').css('li').last
                litag_class_name = last_litag_element.attribute("class").to_s
                if (last_litag_element.css('a').attribute("href").nil? )
                    break
                else
                    litag_href_value = last_litag_element.css('a').attribute("href").value
                end
            end
            #最後に一度クローリングして終了
            #puts driver.current_url
            grifo_onetime_crawl_selenium(doc, duty_free_price, higher_search_price)
        else
            #ページネーションがない場合は1度だけクロール
            doc = Nokogiri::HTML.parse(driver.page_source)
            grifo_onetime_crawl_selenium(doc, duty_free_price, higher_search_price)
        end
        driver.close()
    end
end