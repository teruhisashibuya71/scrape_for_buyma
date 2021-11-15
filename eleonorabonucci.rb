require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'


module Eleonorabonucci
    
    def eleonorabonucci_one_time_crawl(doc, search_price)
        products = doc.css('.div_LIST')
        products.size
        products.each do |product|
        product_price = product.css('.VP_DIV_CONTENITORE_PREZZI').inner_text
            if product_price.include?(search_price) then
                #商品価格
                #puts product_price.strip
                #商品名
                #puts product.css(".name").text.strip
                #画像リンク
                puts "https://eleonorabonucci.com" + product.css('a').attribute("href").value
            end
        end
    end

    def eleonorabonucci_crawl_selenium(brand_home_url, search_price)
    
        
        #ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        #ノーマル
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.manage.window.resize_to(1500,1000)
        
        #価格調整必要無し
        
        #スタート
        driver.get(brand_home_url)

        sleep 2 #バナーすぐでるので長めにsleepする

        #返品無料バナーの削除
        if (driver.find_elements(:id, 'PopupNEWS_div_NAZIONE').size > 0) then
            driver.execute_script('document.getElementById("PopupNEWS_cmdANNULLA").click()')
        end

        sleep 2

        #発送国クリック クリックできるのを待ってからクリック
        driver.find_element(:xpath, '//*[@id="lblPaeseSpedizione"]').click
        #国の選択ウインドウが表示されるまで待つ
        wait.until { driver.find_element(:id, 'PNL_CART').displayed? }
        #japanをクリックしてしてプルダウンを表示
        
        #driver.execute_script('document.getElementsByClassName("SEL_CONTAINER_SEL_LST_SPED_NAZ")[0].click()')
        #プルダウン表示を待つ 待ち方がわからないので
        sleep 1
        #country欄をクリック
        driver.find_element(:id, 'Header1_ChangeSpedNaz_lstSPED_NAZIONI').click
        #ドロップダウンメニューを取得してイタリアを選択
        country_menu_list = driver.find_element(:id, 'Header1_ChangeSpedNaz_lstSPED_NAZIONI')
        select = Selenium::WebDriver::Support::Select.new(country_menu_list)
        select.select_by(:index, 111)

        #同じく通貨→EUROを選択
        driver.find_element(:id, 'Header1_ChangeSpedNaz_lstSPED_VALUTA').click
        currency_menu_list = driver.find_element(:id, 'Header1_ChangeSpedNaz_lstSPED_VALUTA')
        select = Selenium::WebDriver::Support::Select.new(currency_menu_list)
        select.select_by(:index, 0)

        #チェックマークをクリックして終了
        driver.find_element(:id, 'Header1_ChangeSpedNaz_imgBtnOK_SPED').click

        sleep 1
        
        #商品欄が表示されるまで待つ
        wait.until { driver.find_element(:class, 'ViPr_DivLP').displayed? }

        #初回クロール
        doc = Nokogiri::HTML.parse(driver.page_source)
        eleonorabonucci_one_time_crawl(doc, search_price)

        #繰り返し処理 Nextがあるなら繰り返す  VP_lnk_BRAND
        while (doc.css('#body_content_hl_LastPage').size > 0) do
            
            #次のURLを取得するしてアクセス
            next_page_url = "https://eleonorabonucci.com" + doc.css('#body_content_hl_LastPage').css('a').attribute('href').value
            driver.get(next_page_url)
            
            #次の画面に以降して商品が表示されるま待機
            wait.until { driver.find_element(:class, 'ViPr_DivLP').displayed? }

            #docを再度作成
            doc = Nokogiri::HTML.parse(driver.page_source)
            eleonorabonucci_one_time_crawl(doc, search_price)
        end
    end
end