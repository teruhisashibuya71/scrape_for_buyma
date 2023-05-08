#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#ruby z_sel_test.rb

#①url入力
#-------------------------------------------------------------------
brand_home_url = "https://www.pozzilei.it/en/givenchy"
search_price = "290"
#-------------------------------------------------------------------


#②.セレニウム設定
#-------------------------------------------------------------------
#通常version
driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(timeout: 15)
driver.get(brand_home_url)

#ヘッドレスversion
# options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')
# driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
# driver.manage.window.resize_to(1300,1000)
# wait = Selenium::WebDriver::Wait.new(timeout: 15)
# driver.get(brand_home_url)
#-------------------------------------------------------------------


#③.商品エリアの表示を待ってから商品数を確認
#-------------------------------------------------------------------
wait.until { driver.find_element(:id => "items-list").displayed? }
doc = Nokogiri::HTML.parse(driver.page_source)
products = doc.css('.product-item').size
puts products
#-------------------------------------------------------------------


#繰り返し条件
#class = custom-pagination ある ない
# 最後の要素が disabled クラスを持つか 持たないか




#アイテムリストお要素を取得できないので一旦sleepで対応する

#class指定の時 → 「display?」 メソッドになる edでない
#wait.until { driver.find_elements(:class, 'CategoryList').display? }
#wait.until { driver.find_elements(:class, 'CategoryList').display }
#sなくせば最初に見つかった要素を取得

#el = driver.find_elements(:class, 'CategoryList')
#el = driver.find_elements(:class, 'ProductItem')
#puts el.size
#wait.until {el[0].displayed? }

#find_element：最初に見つかった要素を返す
#find_elements：見つかった要素すべてを返す

#wait.until { driver.find_element(:class,'CategoryList').displayed? }
#wait.until { driver.find_elements(:class, 'pagination-select').displayed? }

#アクセスしているページの要素を取得
doc = Nokogiri::HTML.parse(driver.page_source)

#③.商品数を確認
#puts doc.css(".ProductItem").size #24とのこと


# 特定のクラス名を持つ要素を取得
#el = driver.find_element(:class, "pagination mt-3")
items = driver.find_elements(:class, "plp-product")
puts items.size
crawl_repeat_times = page_item_elements.size 

crawled_times = 0
next_page_index = 0

page_item_elements.each_with_index do |element, index|
    if element.attribute("class").include?("active")
        puts "要素は'active'というクラス名を持っています。"
        puts "activeを持つ要素番号は" + index.to_s
        next_page_index = index + 1
    else
        puts "要素は'active'というクラス名を持っていません。"
    end
end

#ページの一番下まで移動
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

#100pxだけ上に戻る
driver.execute_script('window.scrollBy(0, -400)')

elem = doc.at_css('.page-item:nth-last-child(2)').inner_text
#el = driver.find_element(:class, 'page-item:nth-last-child(2)').inner_text
puts "7が表示されるはず" + elem.to_s #動作OK



#指定の要素までスクロールする
#driver.find_element(:class, 'pagination').location_once_scrolled_into_view

puts "OK"
sleep 5

#次のページのリンクをクリックする
driver.find_elements(:class, 'page-item')[next_page_index].click


sleep 5


driver.find_elements(:class, 'page-item')[next_page_index].click




# 特定のクラス名を持つ要素が何番目にあるかを調べる
#index = elements.find_index { |element| element.displayed? }

# 結果を表示する
#puts "特定のクラス名を持つ要素は #{index} 番目にあります。"

# ブラウザを閉じる
driver.quit




#④.商品価格を確認  

#免税になる

#ログインしていない場合ケースの価格のクラス名
#puts doc.css(".prod-price").inner_text

# ログインしている場合の価格いのクラス名 
#puts doc.css(".original-price").inner_text




#currency = 144.7
#adjust_currency = 0.6
#puts adjusted_currency = currency - adjust_currency
#target_price = 70380

#価格を免税価格へ
#duty_free_price = search_price.to_i / 1.2
#duty_free_price = duty_free_price.round.to_s
#puts duty_free_price

#価格を日本円換算へ
#duty_free_price = search_price.to_i / 1.2
#為替分を掛け算して日本円へ
#puts "日本円は"
#puts japanese_yen_price = duty_free_price * adjusted_currency
#puts japanese_yen_price = japanese_yen_price.floor
#puts range_price_low = japanese_yen_price - 1000
#puts range_price_high = japanese_yen_price + 1000
#
#puts boo = target_price.between?(range_price_low,range_price_high)


#ケース1簡単な場合 
#価格桁調整は必要無し
#免税＆＆小数点切り捨て
#duty_free_price = search_price.to_i / 1.22
#duty_free_price = duty_free_price.floor.to_s

#②特定の要素表示まで待つ   491.67 =  143.14円 144.75 0.6引くしかないかも
#wait.until { driver.find_element(:class, 'aproduct_container').displayed? }
#wait.until { driver.find_element(:id, 'pagination-container').displayed? }
#アクセスしているページの要素を取得
#doc = Nokogiri::HTML.parse(driver.page_source)

#③.商品数を確認
#puts doc.css(".product-preview").size

#④.商品価格を確認
#puts doc.css(".price").inner_text

#④.商品価格を確認
#各商品情報を取得
#doc.css(".ajax_block_product").each do |product|
#    #商品価格を取得する
#    if (product.css('.regular-price').empty?) then
#        #セール価格の表記が無いなら定価を比較対象に取得
#        product_price = product.css('.price').inner_text.strip
#        #puts product_price.gsub(" ","")
#    else
#        #セール価格の表記があるならregular_priceを比較対象として取得
#        product_price = product.css('.regular-price').inner_text.strip
#        #puts product_price.gsub(" ","")
#    end
#    puts item_price = product.css(".regular-price").inner_text.strip
#    もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
#    if item_price.include?(search_price) then
#        #商品価格 商品名 画像リンク を取得する
#        puts item_price
#        puts node.css(".name").inner_text
#        puts product_url = "https://www.credomen.com/" + product.css(".itemImg").css('a').attribute("href").value
#    end
#end
        

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

        

