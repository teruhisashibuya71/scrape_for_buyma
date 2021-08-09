#セレニウムのテスト用ファイル
require 'rubygems'
#require 'nokogiri'
#require 'open-uri'
require 'selenium-webdriver'

        #ヘッドレスバージョン
        #options = Selenium::WebDriver::Chrome::Options.new
        #options.add_argument('--headless')
        #driver = Selenium::WebDriver.for :chrome, options: options

        #対象のURL入力
        brand_home_url = "https://www.brunarosso.com/s/designers/maison-margiela/?category=women"
        search_category  = "服"
        search_price  = "480"

        #ノーマル
        driver = Selenium::WebDriver.for :chrome
        driver.get(brand_home_url)
        #wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        
        #国設定用のmodal-windowを操作する
        #国設定用のドロップダウンが表示されるまで待つ→
        wait.until { driver.find_element(:id, 'shipping_country_id').displayed? }
        #ドロップダウンメニューをクリック
        driver.execute_script('document.getElementById("shipping_country_id").click()')
        #italyをクリック
        driver.find_element(:xpath, '//*[@id="shipping_country_id"]/option[106]').click
        #validateボタンをクリック
        driver.find_element(:xpath, '//*[@id="formShippingCountry"]/div[3]/button').click
        
        #もう一度最初のURLへジャンプ
        driver.get(brand_home_url)
        #puts driver.class
        #puts puroducts = driver.find_elements_by_class_name('ajax_block_product')
        #puts puroducts = driver.find_element_by_class_name('ajax_block_product')
        #puts "OK"
        #-----------------------ここまでOK-----------------------------#
        #性別をクリック(例として今回は女性にする)
        #driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/a').click

        #category変数の値に応じて 各カテゴリページのurlを返す  monti_change_country メソッドのdriverを引数にする
        #def monti_return_category_page_url(brand_home_url, search_category)

            if search_category == "服" then
                puts "服の処理を実行している"
                #find_elementは画面切り替わらないのかも
                driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[3]/a').click
                cur_url = driver.current_url
                puts "服の現在のURLの取得完了"
            elsif search_category == "靴" then
                driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[4]/a').click 
            elsif search_category == "バッグ" then
                driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[2]/a').click
            else
                driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[1]/a').click 
            end
        
        #-----------------------画面表示切り替わらないけど動作はOK-----------------------------#

        #seleniumでdocを作成して、商品情報を取得する
        # doc_bySelenium = driver.get(cur_url)
        # puts doc_bySelenium.class
        #def monti_onetime_crowl(doc_bySelenium, search_price)
            driver.get(cur_url)
            puts "rowが表示される10秒待ちます"
            #wait.until { driver.find_element(:class, 'commerce') }
            wait.until { driver.find_element(:class, 'footer-container') }            
            puts "10秒経過"
            
            puts "商品表示OK"
            puroducts = driver.find_elements(:class, 'ajax_block_product')
            puts "productsのクラスのサイズ"
            puts puroducts.length
            #puts puroducts[0] <Selenium::WebDriver::Element:0x00000001240d8958>

            #-----------------------商品データ18個数取得動作OK-----------------------------#

            #一つずつ処理する
            puroducts.each do |product|      
                puts "each文のなか"   
                
                #wait.until { product.find_element(:class => 'regular-price').displayed? }
                #------------------------------------------------------------
                #取得したい項目を1つずつwait → find.element()の流れでやれば取得できる
                #------------------------------------------------------------
                #条件分岐は elemets = driver.find_elements(:class, 'product-price')
                #find_elementsは要素が無くてもでエラーが出ない
                # if (elements.length > 0 ) them
                #要素があった時の処理
                #     puts "OO"
                # else
                #要素がなかった時の処理
                #     puts "OO"
                # end

                wait.until { product.find_element(:class => 'product-price').displayed? }
                x = product.find_element(:class => 'old-price')
                puts x
                
                #puts item_price = product.find_element(:class, 'product-price').text
                # これはうまくいく puts item_price = product.find_element(:class, 'regular-price').text
                if (item_price.include?(search_price)) then
                    puts "商品価格が同じ場合の処理"
                    puts item_price.strip
                    
                    wait.until { product.find_element(:tag_name, 'h5') }
                    puts product_name = product.find_element(:tag_name, 'h5').text

                    wait.until { product.find_element(:class, 'product_img_link') }
                    puts link_url = product.find_element(:class, 'product_img_link').attribute("href")
                end
            end
        #end

         # 十分待てばOK puts product.find_element(:xpath, '//*[@id="price-block-306560"]/div/p/span').text
                # ダメproduct.find_element(:xpath, '//*[@id="price-block-306560"]/div/p').text
                # ダメ puts item_price = product.find_element(:tag_name, 'p').inner_text
                
                # ダメ puts item_price = product.find_element(:tag_name, 'regular-price').text
                #puts item_price = product.find_element(:class, 'regular-price').text
                #puts item_price = product.find_element(:class, 'regular-price').inner_text
                # ダメ puts item_price = product.find_element(:class, 'price').text
                
                #//*[@id="price-block-306560"]/div/p
                #//*[@id="price-block-306560"]/div/p/span

                #//*[@id="price-block-282324"]/div/p/span
                # ダメputs item_price = product.find_element(:class, 'product-price').text
                #puts item_price = product.find_element(:class, 'price product-price').text
        
                # monti_make_doc_bySelenium(driver_source_ajusted_country, categorized_url)
        #     doc_bySelenium = driver_source_ajusted_country.get(categorized_url)
        #     return doc_bySelenium
        # end
        
        #ajax_block_product


    #     #再度最初のURLへジャンプ
    #     country = driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").text
    #     if !country.include?("ITALY") then
    #         #クッキーウインドウのクリック
    #         sleep 0.5
    #         driver.execute_script('document.getElementsByClassName("accept")[0].click()')
    #         sleep 0.5

    #         #会員登録ボタンのjsｆがでてくるかどうかで条件分岐つけたほうが動作安定する
    #         #driver.execute_script('document.getElementsByClassName("brg-btn-green")[0].click()')
    #         #driver.get(brand_home_url)

    #         #発送先Japanをクリック sleep入れないとleft要素見つからない
    #         wait.until { driver.find_element(:class => "links").displayed? }
    #         driver.find_element(:xpath, '/html/body/footer/section/ul[4]/li[3]/a/span').click
    #         sleep 0.5

    #         #発送地域が全て表示されるまで待ってからeuropeをクリック
    #         wait.until { driver.find_element(:class => "left").displayed? }
    #         driver.find_element(:xpath, '/html/body/div[3]/form/div/div[1]/h5[1]').click
    #         #仕方がないのでsleepでで対応
    #         sleep 1

    #         #国の名前が表示されるまで待ってitalyをクリック
    #         wait.until { driver.find_element(:id => 'zona-1').enabled? }
    #         driver.find_element(:xpath, '//*[@id="zona-1"]/ul/li[27]/label').click

    #         #→€クリック
    #         driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/div[1]/ul/li[4]/label').click

    #         #saveボタンクリック
    #         driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/button').click
    #         wait.until { driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").displayed? }
    #         driver.get(brand_home_url)
    #     end
    #     return driver

    # #category変数の値に応じて 各カテゴリページのurlを返す  monti_change_country メソッドのdriverを引数にする
    # def monti_return_category_page_url(brand_home_url, search_category)
    #     if search_category == "服" then
    #         categorized_url = brand_home_url + "/abbigliamento"
    #         return categorized_url
    #     elsif search_category == "靴" then
    #         categorized_url = brand_home_url + "/scarpe"
    #         return categorized_url
    #     elsif search_category == "バッグ" then
    #         categorized_url = brand_home_url + "/borse"
    #         return categorized_url
    #     else
    #         categorized_url = brand_home_url + "/accessori"
    #         return categorized_url
    #     end
    # end

    # #seleniumによる docを作るためのメソッド
    # def monti_make_doc_bySelenium(driver_source_ajusted_country, categorized_url)
    #     doc_bySelenium = driver_source_ajusted_country.get(categorized_url)
    #     return doc_bySelenium
    # end

    # def monti_onetime_crowl(doc_bySelenium, search_price)
    #     puroducts = doc_bySelenium.find_elements(:class, "product")
    #     puroducts.each do |product|
    #         item_price = product.find_element(:class, "price").text
    #         if item_price.include?(search_price) then
    #             puts item_price.strip
    #             puts product_name = product.find_element(:class, "name").text
    #             puts link_url = product.find_element(:tag_name, "a").attribute("href")
    #         end
    #     end
    # end

    # #クロールするメソッド
    # def monti_crowl(brand_home_url, search_price, search_category)
    #     #価格の文字列調整だけ最初に実行
    #     if search_price.length >= 4 then
    #         search_price = search_price.insert(1, ".")
    #     end
    #     driver_source_ajusted_country = monti_change_country(brand_home_url)
    #     #カテゴリー別ページのurlを返す
    #     categorized_url = monti_return_category_page_url(brand_home_url, search_category)
    #     driver_source_ajusted_country.get(categorized_url)
    #     #初回クロール
    #     monti_onetime_crowl(driver_source_ajusted_country, search_price)
    #     #ページ送り機能 クラスnextの中身が空っぽになるまでクロールする　elemetsでないとエラーのになるので注意
    #     if !driver_source_ajusted_country.find_elements(:class, "next").size == 0 then
    #         #次のページのURLを取得
    #         next_page_full_url = driver_source_ajusted_country.find_element(:class, "next").attribute("href")
    #         categorized_url = next_page_full_url
    #         #docを詰め替える
    #         driver_source_ajusted_country = driver_source_ajusted_country.get(categorized_url)
    #         #クローリングする
    #         monti_onetime_crowl(driver_source_ajusted_country, search_price)
    #     end
    # end
