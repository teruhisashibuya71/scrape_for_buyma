require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#特記事項
#カテゴリ無し 
#価格表記はドット「.」
#セール価格→
#免税表示22%
#ページ送りあり 1ページでもpage-nation表示


module Gbselenium

    #クロールするメソッド
    def gb_crawl_selenium(brand_home_url, search_price)
    #def gb_crawl_selenium(brand_home_url, search_price)

        #ヘッドレス
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        #ノーマル
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 8)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)

        sleep 3
        
        current_url = driver.current_url
        while (true) do
            if (current_url.include?("en_jp")) then
                driver.get(brand_home_url)
                sleep 3
                current_url = driver.current_url
            else
                break
            end
        end


        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #商品が無い場合はproducts = 0で終了でいける！
        #最初からURLを操作→クローリングでOK
        sleep 4
        #puts "バナーをクリックします"

        #割引バナーが表示されているなら削除 出るまで最大8秒待つ 出ないなら次の処理へ(elemtentsの効果)
        if (driver.find_elements(:class, 'pagebuilder-column').size != 0) then
            driver.execute_script('document.getElementsByClassName("close-custom-popup")[0].click()')
        end

        sleep 4

        #カテゴリ調整用のコードーーーーーーーーーーーーーーーーーーーーーーーーー
        #少し下にスクロールする
        #driver.execute_script("window.scrollTo(0,500);")
        
        #サイドバーが表示されるまで待つ
        #wait.until { driver.find_elements(:class, 'sidebar-main')[0].displayed? }
        #「CATEGORIA」をクリック
        #driver.find_element(:xpath, '//*[@id="ui-accordion-1-header-0"]').click
        
        #doc = Nokogiri::HTML.parse(driver.page_source)

        #カテゴリーに応じてクリックする場所を変える
        #category_array = driver.find_element(:id, 'ui-accordion-1-panel-0').find_elements(:class, 'item')
        #puts target_elements.size #5
        #target_elements.each do |genre|  
        #    puts genre.text #全て出力できた 
        #end
        #click_index_number = 0
        #クロールする・しないを決めるフラグ
        #crawl_flag = false

        # category_array.each_with_index do |got_category, index|
        #     if (category == "服" && got_category.text == "ABBIGLIAMENTO") then
        #         puts "ふくの条件"
        #             click_index_number = index
        #             puts click_index_number
        #             crawl_flag = true

        #     elsif (category == "靴" && got_category.text == "CALZATURE") then
        #         puts "くつの条件"
                    
        #         click_index_number = index
        #         puts click_index_number
        #                 crawl_flag = true
                    
                
        #     elsif (category == "バッグ" && got_category.text == "BORSE") then
        #         puts "バッグの条件"
                    
        #         click_index_number = index
        #         puts click_index_number
        #                 crawl_flag = true
                    
                
        #     elsif (category == "アクセ" && got_category.text == "ACCESSORI") then
        #         puts "アクセの条件"
        #         click_index_number = index
        #         puts click_index_number
        #                 crawl_flag = true
        #     else
        #         #処理無し
        #     end
        # end

        #フラグがtrueならクロールする
        #if (crawl_flag) then
            #インデックス番号をもとに対象のカテゴリーボタンをクリック

            #5ことれているので
            #puts driver.find_element(:id, 'ui-accordion-1-panel-0').find_elements(:class, 'item')
            
            #sleep 2

            #target_categories = driver.find_element(:id, 'ui-accordion-1-panel-0').find_elements(:class, 'item')
            # puts target_categories.size
            # target_categories.each do |genre|  
            #     puts genre.text #全て出力できた 
            # end

            #target_categories[click_index_number].click
            
            #sleep 2
        #ここまで商品カテゴリー対応コードーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

            #商品リスト全体の表示を待つ element使うと出なかった時にエラー よってelement(s)を使う
            wait.until { driver.find_elements(:class, 'main-grid')[0].displayed? }
            
            #初回クロール
            doc = Nokogiri::HTML.parse(driver.page_source)
            gb_onetime_crawl(doc, search_price)
            
            #ページリストがあるなら繰り返し処理へ
            if (doc.css('.pages').size != 0)
            
                #右矢印(class="pages-item-next")がページから無くなるまでクロールする
                while (doc.css('.pages-item-next').size != 0) do
                    #一番下までスクロール
                    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                    #newsletterウインドウが出てくるなら消す
                    if (driver.find_elements(:class, 'newsletter-content').size != 0) then
                        driver.execute_script('document.getElementsByClassName("close-popup")[0].click()')
                    end
                
                    #右矢印をクリック いちよう2つめの方をクリック
                    #puts driver.find_elements(:class, 'pages-item-next').size
                    urls = doc.css(".pages-item-next").css("a")
                    #puts urls.size
                    next_page_url = urls[1].attribute("href").value
                    driver.get(next_page_url)

                    sleep 3
                    
                    while_current_url = driver.current_url

                    while (true) do
                        if (while_current_url.include?("en_jp")) then
                            driver.get(next_page_url)
                            sleep 3
                            while_current_url = driver.current_url
                        else
                            break
                        end
                    end

                    #次のページの商品が表示されるまで待つ
                    wait.until { driver.find_elements(:class, 'main-grid')[0].displayed? }
                
                    #docを取得してクロールする
                    doc = Nokogiri::HTML.parse(driver.page_source)
                    gb_onetime_crawl(doc, search_price)
                end
            end
        #カテゴリー対応コードーーーーーーーーーーーーーーーーーーーー
        # else
        #     puts "gbには対象のカテゴリの商品がありません"
        # end
        #カテゴリー対応コードーーーーーーーーーーーーーーーーーーーー

    end


    #初回クロール
    def gb_onetime_crawl(doc, search_price)
        products = doc.css('.product-item')
        if (products.size == 0)
            puts "gbには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格あっても取得可能
                product_price = product.css('.price-box').inner_text
                if (product_price.include?(search_price)) then
                #if (product_price.include?(search_price)) then
                    #商品価格
                    #puts product_price.strip
                    #商品名
                    #puts product.css('.product-item-title').text.strip
                    #画像リンク
                    puts product.css('a').attribute("href").value
                end
            end
        end
    end
end