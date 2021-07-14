require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'


module Brunarosso

    def change_country((brand_home_url)
        driver = Selenium::WebDriver.for :chrome #, options: options
        driver.get(brand_home_url)
        wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second

        #国設定ウィンドウの確認
        wait.until { driver.find_element(:xpath => '//*[@id="formShippingCountry"]/div[2]').displayed? }
        driver.execute_script('document.getElementsByClassName("brg-btn-green")[0].click()')



    end//*[@id="shipping_country_id"]

    def brunarosso_crowl(brand_home_url)
        driver = Selenium::WebDriver.for :chrome #, options: options
        driver.get(brand_home_url)
        wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
        wait.until { driver.find_element(:xpath => '//*[@id="center_column"]/div/div[2]/div[2]').displayed? }

        driver.execute_script('document.getElementsByClassName("brg-btn-green")[0].click()')
        driver.find_element(:xpath, '//*[@id="product-container-262664"]/div[2]').click
    end

    #category変数の値に応じて 各カテゴリページのurlを返すメソッド 引数はvipfendiクラスのクラス変数が入る
    def brunarosso_return_category_page_url(attack_site_url, search_category)
        #連結用のベースurl
        url = "https://www.brunarosso.com/s/designers/fendi/?category="
        home_doc = brunarosso_make_doc(attack_site_url)
        if search_category == "服" then
            brunarosso_clothing_url = home_doc.css('li[data-slug="clothing-1"]').css('a').attribute("href").value 
            return brunarosso_clothing_url
        elsif search_category == "靴" then
            brunarosso_shoes_url = home_doc.css('li[data-slug="shoes-1"]').css('a').attribute("href").value
            return brunarosso_shoes_url
        elsif search_category == "バッグ" then
            brunarosso_bag_url = home_doc.css('li[data-slug="bags-2"]').css('a').attribute("href").value
            return brunarosso_bag_url
        else
            brunarosso_accessories_url = home_doc.css('li[data-slug="accessories-2""]').css('a').attribute("href").value
            return brunarosso_accessories_url
        end
    end


    #クロールするメソッド
    def brunarosso_clowl(attack_site_url, search_price, search_category)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
        #カテゴリーに応じたページURLを取得
        category_page_url = brunarosso_return_category_page_url(attack_site_url, search_category)
        #カテゴリーに応じたhtml構造を取得 まずはcategory_page_urlが配列かどうかを判断する
        if category_page_url.instance_of?(Array) then
            #配列に対してクロールする
            category_page_url.each do |target_url|
                doc = brunarosso_make_doc(target_url)
                doc.css('.product-box').each do |node|
                    #商品価格を取得する  価格が同じなら商品名とリンクURLを取得する
                    item_price = node.css("span.price").inner_text
                    #もし価格が同じなら
                    if item_price.include?(search_price) then
                        #商品価格 商品名 画像リンク を取得する
                        puts item_price.gsub(" ", "")
                        puts node.css(".product-name").inner_text.strip
                        get_url = node.css('a').attribute("href").value #フルurlが取得される
                        puts get_url
                    end
                end
            end
        else
            #通常のクロールを行う
            doc = brunarosso_make_doc(category_page_url)
            doc.css('.product-box').each do |node|
                #商品価格を取得する  価格が同じなら商品名とリンクURLを取得する
                item_price = node.css("span.price").inner_text
                #もし価格が同じなら
                if item_price.include?(search_price) then
                    #商品価格 商品名 画像リンク を取得する
                    puts item_price.gsub(" ", "")
                    puts node.css(".product-name").inner_text.strip
                    get_url = node.css('a').attribute("href").value #フルurlが取得される
                    puts get_url
                end
            end
        end
    end
end