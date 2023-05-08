require 'rubygems'
require 'nokogiri'
require 'open-uri'


#✓後でページ送り機能を念のため付ける
module Wise

    #クロールするメソッド
    def wise_crawl_selenium(brand_home_url, search_price)
        #def wise_crawl_selenium(brand_home_url, search_price)
    
            #ヘッドレス
            options = Selenium::WebDriver::Chrome::Options.new
            options.add_argument('--headless')
            driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
            #ノーマル
            #driver = Selenium::WebDriver.for :chrome
            wait = Selenium::WebDriver::Wait.new(timeout: 8)
            driver.manage.window.resize_to(1300,1000)
            driver.get(brand_home_url)
    
            sleep 3
            
            current_url = driver.current_url

            #ちゃんとしたページが表示されるまで繰り返しアクセスする
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
                search_price = search_price.insert(1, ",")
            end
    
            #商品が無い場合はproducts = 0で終了でいける！
            #最初からURLを操作→クローリングでOK
            sleep 4
            #puts "バナーをクリックします"
    
            #割引バナーが表示されているなら削除 出るまで最大8秒待つ 出ないなら次の処理へ(elemtentsの効果)
            # if (driver.find_elements(:class, 'pagebuilder-column').size != 0) then
            #     driver.execute_script('document.getElementsByClassName("close-custom-popup")[0].click()')
            # end
    
             #サイドバー表示されるまで待ってからクリック //*[@id="ui-accordion-1-header-0"]
            # wait.until { driver.find_elements(:class, 'sidebar-main')[0].displayed? }
            # driver.find_element(:xpath, '//*[@id="ui-accordion-1-header-0"]').click
            
            #puts "サイドバークリック"
            #かてごり一覧が完全に表示されるのを待ってからクリック
            # wait.until { driver.find_element(:xpath, '//*[@id="ui-accordion-1-panel-0"]/div/ol/li[1]').displayed? }
            # driver.find_element(:xpath, '//*[@id="ui-accordion-1-panel-0"]/div/ol/li[1]').click
    
    
            #商品リスト全体の表示を待つ element使うと出なかった時にエラー よってelement(s)を使う
            wait.until { driver.find_elements(:class, 'main-grid')[0].displayed? }
            
            #doc作成と初回クロール
            doc = Nokogiri::HTML.parse(driver.page_source)
            wise_onetime_crawl(doc, search_price)
            
            #ページ数表示が1でなければ繰り返し処理へ id=pagination
            #if (doc.css('#pagination').css('li').size != 1)
            if (doc.css('.pages').size != 0)
    
                #2回目からは免税価格にする
                #duty_free_price = search_price.to_i / 1.22
                #duty_free_price = duty_free_price.floor.to_s
                
                #右矢印(class="pages-item-next")がページから無くなるまでクロールする
                while (doc.css('.pages-item-next').size != 0) do
    
                    #一番下までスクロール
                    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    
                    #newsletterでてきたら削除する 
                    # if (driver.find_elements(:class, 'newsletter-content').size != 0) then
                    #     driver.execute_script('document.getElementsByClassName("close-popup")[0].click()')
                    # end
                    
                    #右矢印をクリック いちよう2つめの方をクリック
                    #puts driver.find_elements(:class, 'pages-item-next').size
    
                    urls = doc.css(".pages-item-next").css("a")
                    #puts urls.size
                    url = urls[1].attribute("href").value
                    driver.get(url)
                    #driver.find_elements(:class, 'pages-item-next')[1].click
    
                    sleep 4
                    #次のページの商品が表示されるまで待つ
                    wait.until { driver.find_elements(:class, 'main-grid')[0].displayed? }
                    
                    #docを取得してクロールする
                    doc = Nokogiri::HTML.parse(driver.page_source)
                    wise_onetime_crawl(doc, search_price)
                end
            end
        end
    
    
        #初回クロール
        def wise_onetime_crawl(doc, search_price)
            products = doc.css('.product-item')
            if (products.size == 0)
                puts "wiseには該当ブランドの商品が現在ありません"
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