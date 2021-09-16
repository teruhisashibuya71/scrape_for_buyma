#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'


        #アクセス先のURL入力
        brand_home_url = "https://www.credomen.com/dsquared2/"
        #brand_home_url = "https://www.credomen.com/moncler/"
        search_price = "645"
        
        #options = Selenium::WebDriver::Chrome::Options.new
        #options.add_argument('--headless')
        #driver = Selenium::WebDriver.for :chrome, options: options
        driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 60)
        driver.get(brand_home_url)

        sleep 2

        #価格桁調整は必要無し

        #免税＆＆小数点切り捨て
        #duty_free_price = search_price.to_i / 1.22
        #duty_free_price = duty_free_price.floor.to_s

        #商品リストが表示されるまで待つ
        wait.until { driver.find_element(:id, 'overview').displayed? }

        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        sleep 0.5
        driver.execute_script("window.scrollBy(document.body.scrollHeight, -600);")

        #docを取得
        doc = Nokogiri::HTML.parse(driver.page_source)

        #we are very sorry対策
        if (doc.css(".item").size == 0) then
            puts "credmanのページ読み込みでエラーが生じました。手動で確認してください"
        end
        
        #page数を取得
        page_amount = doc.css('.pagination').css('li').size
        #ページ数が2の時処理 ページ1とページ2しか無い場合
        if (page_amount == 2) then
            
            #初回クロール
            doc.css(".item").each do |product|
                #商品価格を取得する
                item_price = product.css(".priceOffer").inner_text
                #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
                if item_price.include?(search_price) then
                    #商品価格 商品名 画像リンク を取得する
                    #puts item_price
                    #puts node.css(".name").inner_text
                    puts product_url = "https://www.credomen.com/" + product.css(".itemImg").css('a').attribute("href").value
                end
            end

            #2を押す 最後のpageNumber
            driver.find_elements(:class, 'pageNumber').last.click

            #待つしかないかな〜
            sleep 5
            
            #doc再取得
            doc = Nokogiri::HTML.parse(driver.page_source)

            #2ページ目をクロールして終了
            doc.css(".item").each do |product|
                #商品価格を取得する
                item_price = product.css(".priceOffer").inner_text
                #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
                if item_price.include?(search_price) then
                    #商品価格 商品名 画像リンク を取得する
                    #puts item_price
                    #puts node.css(".name").inner_text
                    puts product_url = "https://www.credomen.com/" + product.css(".itemImg").css('a').attribute("href").value
                end
            end

        #ページ数が2以上の時
        elsif (page_amount > 2) 
            
            #class="lastの"inner_textを取得して代入 (数字にする)
            crawl_times = doc.css('.pagination').css('.firstLast').inner_text.to_i #出力→3
            
            #crawl_time_index = 0を用意
            crawl_time_index = 0
            break_index = 0
            #その数字をもとに繰り返し処理の回数を指定 times構文
            crawl_times.times do
                #初回クロール
                doc.css(".item").each do |product|
                    #商品価格を取得する
                    item_price = product.css(".priceOffer").inner_text
                    #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
                    if item_price.include?(search_price) then
                        #商品価格 商品名 画像リンク を取得する
                        #puts item_price
                        #puts node.css(".name").inner_text
                        puts product_url = "https://www.credomen.com/" + product.css(".itemImg").css('a').attribute("href").value
                    end
                end
                
                driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                sleep 0.5
                driver.execute_script("window.scrollBy(document.body.scrollHeight, -600);")

                #クリックするページ番号を指定する番号
                crawl_time_index += 1
                puts "#{crawl_time_index}" + "回目のクロール終了"

                break_index += 1  #クリックするページ番号を指定する番号
                    #繰り返し処理の最後の1回はクリックするページが無いのでbreak
                    if (crawl_times == break_index)
                        break
                    else
                        driver.find_elements(:class, "pageNumber")[crawl_time_index].click #indexをもとにページ番号をクリックして次のページへ
                        sleep 4
                        doc = Nokogiri::HTML.parse(driver.page_source) #再度docを取得
                    end
            end
        else #ページ数が1の時の処理
            #クロールして終了
            doc.css(".item").each do |product|
                #商品価格を取得する
                item_price = product.css(".priceOffer").inner_text
                #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
                if item_price.include?(search_price) then
                    #商品価格 商品名 画像リンク を取得する
                    #puts item_price
                    #puts node.css(".name").inner_text
                    puts product_url = "https://www.credomen.com/" + product.css(".itemImg").css('a').attribute("href").value
                end
            end
        end


        
        #ページ数が1より大きいなら繰り返し処理へ
        # if (doc.css('.pagination').css('.pageNumber')size != 1) then
        #     #ページ送り用の右矢印「>」 next-pageクラスがなくなるまでクロールする
        #     while (doc.css('.next-page').size != 0) do
                
        #         #最下層へ移動してからリンクをクリックして次のページに移動
        #         driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        #         driver.execute_script("window.scrollBy(document.body.scrollHeight, -500);")
        #         driver.find_element(:class, 'next-page').click

        #         sleep 1

        #         #商品商品表示領域が表示されるまで待つ
        #         wait.until { driver.find_element(:class, 'center-2').displayed? }

        #         #次のページのdocを取得してクロールしなおす
        #         doc = Nokogiri::HTML.parse(driver.page_source)
        #         #spinnaker_onetime_crawl(search_price, doc)

            
        #         sleep 2


        #     end
        # end


        # if (products.size == 0)
        #     puts "spinnakerには該当ブランドの商品が現在ありません"
        # else
        #     products.each do |product|
        #         puts product_price = product.css('.prices').inner_text
        #         #puts product.css('.product-item__link').attribute("href").value
        #         if (product_price.include?(duty_free_price)) then
        #             #商品価格
        #             puts product_price.strip
        #             #商品名
        #             puts product.css('.product-item-title').text.strip
        #             #画像リンク
        #             puts product.css('.picture').css('a').attribute("href").value
        #         end
        #     end
        # end

        


        # #クッキーウィンドウを処理  ボタンあるならクリックする
        # if driver.find_elements(:class, 'iubenda-cs-accept-btn').size != 0 then
        # #if driver.find_element(:class, 'iubenda-cs-accept-btn').displayed?
        #     driver.execute_script('document.getElementsByClassName("iubenda-cs-accept-btn")[0].click()')
        #     #driver.execute_script('document.getElementByXpath("//*[@id="iubenda-cs-banner"]/div/div/div/div[2]/div[2]/button[2]").click()')
        # end

        # sleep 1



        # #商品一覧が表示されるまで待つ
        # wait.until { driver.find_element(:id, 'maincontent').displayed? }

        # sleep 1

        
        # #サイドバーはなぜか表示されない
        # #下までスクロールして少し戻る
        # driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        # driver.execute_script("window.scrollBy(document.body.scrollHeight, -400);")

        # sleep 1


        # #LOADボタンが1つも無い時のための分岐 無いなら繰り返し処理じたいに入らない
        # if driver.find_element(:class, 'jsLoadMoreProducts').displayed? then
        #     #LOADMOREボタンがhiddendになるまでくりかえす
        #     while (true) do

        #         #LOADボタンをクリックする前にバナーの表示チェック
        #         if driver.find_elements(:class, 'popup-content').size != 0 then
        #         #if driver.find_elements(:class, 'popup-content')[0].displayed? then
        #             driver.execute_script('document.getElementsByClassName("mfp-close")[0].click()')
        #         end

        #         #LOADボタンエリアをクリック
        #         driver.find_element(:class, 'jsLoadMoreProducts').click
        #         puts "LOADボタンクリック"
                
        #         sleep 1

        #         #一番下までサイドスクロール
        #         driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        #         driver.execute_script("window.scrollBy(document.body.scrollHeight, -400);")

        #         sleep 1

        #         #LOADMOREボタンが見つからなくなったら繰り返し処理を抜ける                
        #         if (!driver.find_element(:class, 'jsLoadMoreProducts').displayed?) then
        #             break
        #         end
        #     end
        # end

        # sleep 1

        # #docを取得
        # doc = Nokogiri::HTML.parse(driver.page_source)
        # products = doc.css('.product-item')

        # #商品価格の調整はコンマ
        # if search_price.length >= 4 then
        #     search_price = search_price.insert(1, ".")
        # end
        
        # if (products.size == 0)
        #     puts "genteromaには該当ブランドの商品が現在ありません"
        # else
        #     products.each do |product|
        #         product_price = product.css('.price-box').inner_text
        #         #puts product.css('.product-item__link').attribute("href").value
        #         if (product_price.include?(search_price)) then
        #             #商品価格
        #             #puts product_price.strip
        #             #商品名
        #             #puts product.css('.product-item-title').text.strip
        #             #画像リンク
        #             puts product.css('.product-item-info').css('a').attribute("href").value
        #         end
        #     end
        # end

        

