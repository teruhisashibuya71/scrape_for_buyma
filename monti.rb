require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#✓後でページ送り機能を念のため付ける
module Monti

    #€価格表示にするメソッド driverを返す
    def monti_change_country(brand_home_url)
        
        #ヘッドレスは2行+options
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        driver.get(brand_home_url)
        wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
        wait.until { driver.find_element(:xpath => "/html/body/footer/section").displayed? }
        country = driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").text
        if !country.include?("ITALY") then
            #クッキーウインドウのクリック
            sleep 0.5
            driver.execute_script('document.getElementsByClassName("accept")[0].click()')
            sleep 0.5

            #会員登録ボタンのjsｆがでてくるかどうかで条件分岐つけたほうが動作安定する
            #driver.execute_script('document.getElementsByClassName("brg-btn-green")[0].click()')
            #driver.get(brand_home_url)

            #発送先Japanをクリック sleep入れないとleft要素見つからない
            wait.until { driver.find_element(:class => "links").displayed? }
            driver.find_element(:xpath, '/html/body/footer/section/ul[4]/li[3]/a/span').click
            sleep 0.5

            #発送地域が全て表示されるまで待ってからeuropeをクリック
            wait.until { driver.find_element(:class => "left").displayed? }
            driver.find_element(:xpath, '/html/body/div[3]/form/div/div[1]/h5[1]').click
            #仕方がないのでsleepでで対応
            sleep 1

            #国の名前が表示されるまで待ってitalyをクリック
            wait.until { driver.find_element(:id => 'zona-1').enabled? }
            driver.find_element(:xpath, '//*[@id="zona-1"]/ul/li[27]/label').click

            #→€クリック
            driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/div[1]/ul/li[4]/label').click

            #saveボタンクリック
            driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/button').click
            wait.until { driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").displayed? }
            driver.get(brand_home_url)
        end
        return driver
    end

    #category変数の値に応じて 各カテゴリページのurlを返す  monti_change_country メソッドのdriverを引数にする
    def monti_return_category_page_url(brand_home_url, search_category)
        if search_category == "服" then
            categorized_url = brand_home_url + "/abbigliamento"
            return categorized_url
        elsif search_category == "靴" then
            categorized_url = brand_home_url + "/scarpe"
            return categorized_url
        elsif search_category == "バッグ" then
            categorized_url = brand_home_url + "/borse"
            return categorized_url
        else
            categorized_url = brand_home_url + "/accessori"
            return categorized_url
        end
    end

    #seleniumによる docを作るためのメソッド
    def monti_make_doc_bySelenium(driver_source_ajusted_country, categorized_url)
        doc_bySelenium = driver_source_ajusted_country.get(categorized_url)
        return doc_bySelenium
    end

    def monti_onetime_crowl(doc_bySelenium, search_price)
        puroducts = doc_bySelenium.find_elements(:class, "product")
        puroducts.each do |product|
            item_price = product.find_element(:class, "price").text
            if item_price.include?(search_price) then
                puts item_price.strip
                puts product_name = product.find_element(:class, "name").text
                puts link_url = product.find_element(:tag_name, "a").attribute("href")
            end
        end
    end

    #クロールするメソッド
    def monti_crowl(brand_home_url, search_price, search_category)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
        driver_source_ajusted_country = monti_change_country(brand_home_url)
        #カテゴリー別ページのurlを返す
        categorized_url = monti_return_category_page_url(brand_home_url, search_category)
        driver_source_ajusted_country.get(categorized_url)
        #初回クロール
        monti_onetime_crowl(driver_source_ajusted_country, search_price)
        #ページ送り機能 クラスnextの中身が空っぽになるまでクロールする　elemetsでないとエラーのになるので注意
        if !driver_source_ajusted_country.find_elements(:class, "next").size == 0 then
            #次のページのURLを取得
            next_page_full_url = driver_source_ajusted_country.find_element(:class, "next").attribute("href")
            categorized_url = next_page_full_url
            #docを詰め替える
            driver_source_ajusted_country = driver_source_ajusted_country.get(categorized_url)
            #クローリングする
            monti_onetime_crowl(driver_source_ajusted_country, search_price)
        end
    end
end
