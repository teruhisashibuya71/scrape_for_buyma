#セレニウムのテスト用ファイル
#日本円対策
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#ruby z_sel_japan_yen.rb
#①url入力
brand_home_url = "https://www.papinistore.com/it/donna-brand-maison-margiela"
search_price = "1250"
currency = 144.7 
adjust_currency = 0.6
puts adjusted_currency = currency - adjust_currency
#search_price = 70380

#価格を免税価格へ
puts duty_free_price = search_price.to_i / 1.2
puts duty_free_price = duty_free_price.round.to_s
puts duty_free_price

#日本円対策 価格を日本円換算へ 
duty_free_price = search_price.to_i / 1.2

#為替分を掛け算して日本円へ
puts "日本円は"
puts japanese_yen_price = duty_free_price * adjusted_currency
puts japanese_yen_price = japanese_yen_price.floor
if (japanese_yen_price >= 100000) then 
    puts range_price_low = japanese_yen_price - 2500
    puts range_price_high = japanese_yen_price + 2500  
else 
    puts range_price_low = japanese_yen_price - 1500
    puts range_price_high = japanese_yen_price + 1500
end

#puts boo = search_price.between?(range_price_low,range_price_high)


#通常version
# driver = Selenium::WebDriver.for :chrome
# wait = Selenium::WebDriver::Wait.new(timeout: 60)
# driver.get(brand_home_url)

#ヘッドレス
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')
wait = Selenium::WebDriver::Wait.new(timeout: 30)
driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
driver.manage.window.resize_to(1500,1000)
driver.get(brand_home_url)

#ケース1簡単な場合 
#価格桁調整は必要無し
#免税＆小数点切り捨て
#duty_free_price = search_price.to_i / 1.22
#duty_free_price = duty_free_price.floor.to_s

#②特定の要素表示まで待つ   491.67 =  143.14円 144.75 0.6引くしかないかも
wait.until { driver.find_element(:class, 'aproduct_container').displayed? }
#wait.until { driver.find_element(:id, 'aproduct_container').displayed? }

#アクセスしているページの要素を取得
doc = Nokogiri::HTML.parse(driver.page_source)

#③.商品数を確認
#puts "③"
#puts doc.css(".prodottoPreview").size

#④.商品価格を確認
#puts "④"
#puts doc.css(".prodottoPrice").inner_text.delete(",").delete("¥")
#puts doc.css(".prodottoDiscounted").inner_text.delete(",").delete("¥")

#prodottoDiscounted
#prodottoPrice


#④-1.商品価格を確認
#各商品情報を取得
#doc.css(".prodottoPreview").each do |item|
#    #商品価格を取得する
#    #puts item_price = item.css(".regular-price").inner_text.strip
#    #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
#    if item_price.include?(search_price) then
#        #商品価格 商品名 画像リンク を取得する
#        puts item_price
#        puts item.css(".prodottoName").inner_text
#        puts item_url = "https://www.papinistore.com/" + product.css(".prodottoPreview").css('a').attribute("href").value
#    end
#end


#④-2.商品価格を確認
#各商品情報を取得(セール価格表記を考慮したバージョン)
doc.css(".prodottoPreview").each do |item|
    #商品価格を取得する
    #セール価格の表記が無い場合
    if (item.css('.prodottoDiscounted').empty?) then  #
        item_price = item.css('.prodottoPrice').inner_text.delete(",").delete("¥")  #
        puts "標準価格"
        puts item_price.gsub(" ","")
    else
        #セール価格の表記がある場合
        item_price = item.css('.prodottoDiscounted').inner_text.delete(",").delete("¥")  #
        puts item_price.gsub(" ","")
    end


    #もし商品価格がsearch_priceと同じなら商品名とリンクURLを取得する
#     if item_price.include?(search_price) then
#      #商品価格 商品名 画像リンク を取得する
#         puts item_price
#         puts item.css(".prodottoName").inner_text
#         puts item_url = "https://www.papinistore.com/" + product.css(".prodottoPreview").css('a').attribute("href").value
#     end


    #日本円比較の場合は±1000¥の範囲指定で比較する
    item_price = item_price.to_i
    if item_price.between?(range_price_low,range_price_high) then
        #商品価格 商品名 画像リンク を取得する
        puts item_price
        puts item.css(".prodottoName").inner_text
        #puts item_url = "https://www.papinistore.com/" + item.css(".prodottoPreview").css('a').attribute("href").value
        puts item_url = "https://www.papinistore.com/" + item.css('a').attribute("href").value
    end


end
        

        #ログイン処理の自動化
        #wait.until { driver.find_element(:id, 'loginutente').displayed? }
        #el = driver.find_element(:xpath, '//*[@id="loginutente"]/div/div/div[1]/div[2]/form/input[3]')
        #el.send_keys('lshibuya.ts@gmail.com')
        #el = driver.find_element(:xpath, '//*[@id="loginutente"]/div/div/div[1]/div[2]/form/input[4]')
        #el.send_keys('b2bcartishibuya')
        #el = driver.find_element(:xpath, '//*[@id="loginutente"]/div/div/div[1]/div[2]/form/input[6]')
        #el.click

        #メンズ・レディースの表示を待つ
        #wait.until { driver.find_element(:xpath => '//*[@id="sticker"]').displayed?}        

        #page_source = "https://www.minettiangeloonline.com/it/man?idt=10000012"
        #driver.get("https://www.minettiangeloonline.com/it/man?idt=10000012")
        #driver.get("https://www.minettiangeloonline.com/it/man?idt=66")

        #wait.until { driver.find_element(:id => 'catalogogen').displayed?}     

        #doc = Nokogiri::HTML.parse(driver.page_source)
        
        #初回クロール
        #angelo_onetime_crawl_selenium(doc, custom_price)

        #puts doc.css('.bloccopagine').at_css('.pagine').inner_text
        
        #str = doc.css('.bloccopagine').at_css('.pagine').inner_text

        #puts doc.search('.bloccopagine .pagine:nth-last-child(2)')
        #elem = doc.at_css('.bloccopagine .pagine:nth-last-child(2)').inner_text
        #clowled_urls = []
        #if (elem = "") then
        #    #後ろから2番目のpagineの中身が""でなくなるまでクローリング
        #    while (elem = "") do
        #        #後ろから2番目のリンクをクリックして次のページに移動
        #        puts "くりかえし"
        #        puts target_link = doc.at_css('.bloccopagine .pagine:nth-last-child(2)').css('a').attribute("href").value
        #        puts next_page_url = "https://www.minettiangeloonline.com/it/" + target_link
        #        
        #        #クロール済みurlの配列に加える
        #        clowled_urls.push(driver.current_url)
        #        
        #        driver.get(next_page_url)
        #        if (clowled_urls.include?(driver.current_url)) then
        #            break
        #        end
        #        wait.until { driver.find_element(:id => 'catalogogen').displayed?}
        #        
        #        sleep 3
#
        #        #doc詰め直し
        #        doc = Nokogiri::HTML.parse(driver.page_source)
        #        #elemの中身を更新
        #        
        #        #クロール
        #    end
        #end
        
        

        #if (str = "") then
        #    puts "abc"
        #else
        #    
        #end
        # #paginationがあるかどうかでで繰り返し or 1回だけ
        # paginate = driver.find_elements(:class => 'pagine')
        # if (paginate.size > 1) then
        #     puts "abc"
        # else
        #     #angelo_onetime_crawl_selenium(doc, custom_price)
        # end

        


        #画面下までスクロールする処理
        #driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        #sleep 0.5
        #driver.execute_script("window.scrollBy(document.body.scrollHeight, -600);")

        #docを取得
        #doc = Nokogiri::HTML.parse(driver.page_source)

        #we are very sorry対策
        #if (doc.css(".item").size == 0) then
        #    puts "credmanのページ読み込みでエラーが生じました。手動で確認してください"
        #end
        
        #page数を取得
        #page_amount = doc.css('.pagination').css('li').size
        #ページ数が2の時処理 ページ1とページ2しか無い場合
        # if (page_amount == 2) then
            
        #     #初回クロール
        #     doc.css(".item").each do |product|
        #         #商品価格を取得する
        #         item_price = product.css(".priceOffer").inner_text
        #         #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
        #         if item_price.include?(search_price) then
        #             #商品価格 商品名 画像リンク を取得する
        #             #puts item_price
        #             #puts node.css(".name").inner_text
        #             puts product_url = "https://www.credomen.com/" + product.css(".itemImg").css('a').attribute("href").value
        #         end
        #     end

        #     #2を押す 最後のpageNumber
        #     driver.find_elements(:class, 'pageNumber').last.click

        #     #待つしかないかな〜
        #     sleep 5
            
        #     #doc再取得
        #     doc = Nokogiri::HTML.parse(driver.page_source)

        #     #2ページ目をクロールして終了
        #     doc.css(".item").each do |product|
        #         #商品価格を取得する
        #         item_price = product.css(".priceOffer").inner_text
        #         #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
        #         if item_price.include?(search_price) then
        #             #商品価格 商品名 画像リンク を取得する
        #             #puts item_price
        #             #puts node.css(".name").inner_text
        #             puts product_url = "https://www.credomen.com/" + product.css(".itemImg").css('a').attribute("href").value
        #         end
        #     end

        # #ページ数が2以上の時
        # elsif (page_amount > 2) 
            
        #     #class="lastの"inner_textを取得して代入 (数字にする)
        #     crawl_times = doc.css('.pagination').css('.firstLast').inner_text.to_i #出力→3
            
        #     #crawl_time_index = 0を用意
        #     crawl_time_index = 0
        #     break_index = 0
        #     #その数字をもとに繰り返し処理の回数を指定 times構文
        #     crawl_times.times do
        #         #初回クロール
        #         doc.css(".item").each do |product|
        #             #商品価格を取得する
        #             item_price = product.css(".priceOffer").inner_text
        #             #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
        #             if item_price.include?(search_price) then
        #                 #商品価格 商品名 画像リンク を取得する
        #                 #puts item_price
        #                 #puts node.css(".name").inner_text
        #                 puts product_url = "https://www.credomen.com/" + product.css(".itemImg").css('a').attribute("href").value
        #             end
        #         end
                
        #         driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        #         sleep 0.5
        #         driver.execute_script("window.scrollBy(document.body.scrollHeight, -600);")

        #         #クリックするページ番号を指定する番号
        #         crawl_time_index += 1
        #         puts "#{crawl_time_index}" + "回目のクロール終了"

        #         break_index += 1  #クリックするページ番号を指定する番号
        #             #繰り返し処理の最後の1回はクリックするページが無いのでbreak
        #             if (crawl_times == break_index)
        #                 break
        #             else
        #                 driver.find_elements(:class, "pageNumber")[crawl_time_index].click #indexをもとにページ番号をクリックして次のページへ
        #                 sleep 4
        #                 doc = Nokogiri::HTML.parse(driver.page_source) #再度docを取得
        #             end
        #     end
        # else #ページ数が1の時の処理
        #     #クロールして終了
        #     doc.css(".item").each do |product|
        #         #商品価格を取得する
        #         item_price = product.css(".priceOffer").inner_text
        #         #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
        #         if item_price.include?(search_price) then
        #             #商品価格 商品名 画像リンク を取得する
        #             #puts item_price
        #             #puts node.css(".name").inner_text
        #             puts product_url = "https://www.credomen.com/" + product.css(".itemImg").css('a').attribute("href").value
        #         end
        #     end
        # end


        
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

        

