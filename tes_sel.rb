#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#要素の有無の確認 element で要素が無い場合は エラーになってしまうので、必ずelementsで対応する elementsでもid指定は可能
# if (driver.find_elements(:id, 'cookie-law-hide').size != 0) then
#     driver.execute_script('document.getElementById("cookie-law-hide").click()')
# end

#下の記述でも問題無し 「element」に 「.displayed?」は使えないので注意が必要
#if (driver.find_elements(:class, 'pagebuilder-column')[0].displayed?) then
#driver.execute_script('document.getElementsByClassName("close-custom-popup")[0].click()')
#end

#バナー系
#ためしにaリンク押してみるbrg-btn-green 以下成功
#driver.execute_script('document.getElementById("brg-modal-content").getElementsByClassName("brg-btn-green")[0].click()')


#参考
#https://sakaimo.hatenablog.com/entry/2014/06/14/165742

#ヘッドレスバージョン

        #対象のURL入力
        #brand_home_url = "https://www.antonia.it/it/brands/moncler"
        brand_home_url = "https://www.thedoublef.com/it_en/man/designers/prada/"
        search_category  = "服"
        search_price  = "590"

        #ヘッドレスバージョン
        #options = Selenium::WebDriver::Chrome::Options.new
        #options.add_argument('--headless')
        #driver = Selenium::WebDriver.for :chrome, options: options
        #ノーマル
        driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.get(brand_home_url)

        sleep 10

        #メインコンテンツ表示されるまで待つ
        wait.until { driver.find_element(:class, 'pagebuilder-column-group').displayed? }
        #クリックdesignerをクリック
        driver.find_element(:xpath, '//*[@id="maincontent"]/div[2]/div[2]/div/div/div[2]/div/div/div/ul/li[2]').click

        sleep 1

        wait.until { driver.find_element(:class, 'lists-container').displayed? }
        #pradaをクリック
        driver.find_element(:xpath, '//*[@id="maincontent"]/div[2]/div[2]/div/div/div/div/div[2]/div[2]/div/ul[17]/li[7]').click

        sleep 1


        #サイドバーのcategoriaが表示されるのを待ってからcategoriaをクリック
        wait.until { driver.find_element(:id, 'narrow-by-list').displayed? }

        #ポップアップ表示があるなら消す elementsにしないと エラー返すので注意すること
        if driver.find_elements(:class, 'custom_popup').size != 0
            #ポップアップウインドウの×を押して消す
            puts "ポップアップウインドウを認識"
            puts driver.find_elements(:class, 'close-custom-popup').size #1
            puts driver.find_elements(:class, 'svg-sprite').size  #2
            #driver.execute_script('document.getElementByXpath("//*[@id="html-body"]/div[1]/div/div[1]/a").click()')
            #反応無し↓
            driver.execute_script('document.getElementsByClassName("close-custom-popup")[0].click()')
            #driver.execute_script('document.getElementsByClassName("svg-sprite")[0].click()')　#click is not afunctuon
            #driver.execute_script('document.getElementsByClassName("svg-sprite")[1].click()') #click is not afunctuon
            
            
            
            #driver.execute_script('document.getElementsByClassName("svg-sprite")[1].click()') not a functionエラー
            
            puts "oseta"
        end

        #if driver.find_element(:class, 'custom_popup').displa  

        #カテゴリーをクリック
        driver.find_element(:xpath, '//*[@id="ui-accordion-1-header-0"]').click

        sleep 5

        #各カテゴリーのクリック
        if search_category == "服" then
            #ol class=no_max_height の最初のli
            driver.find_element(:class, 'no_max_height').find_element(:tag_name, 'li').click
            
        elsif search_category == "靴" then
            gb_shoes_url = attack_site_url + "?macrocategory=CALZATURE"
            return gb_shoes_url
        elsif search_category == "バッグ" then
            gb_bag_url = attack_site_url + "?macrocategory=BORSE"
            #puts gb_bag_url
            return gb_bag_url
        else
            gb_accessori_url = attack_site_url + "?macrocategory=ACCESSORI"
            return gb_accessori_url
        end

# def monti_one_time_crawl(doc, search_price)
#     products = doc.css('.product')
#     products.each do |product|
#     product_price = product.css('.price').inner_text
#         if product_price.include?(search_price) then
#             #商品価格
#             #puts product_price.strip
#             #商品名
#             #puts product.css(".name").text.strip
#             #画像リンク
#             puts "https://www.montiboutique.com/" + product.css('a').attribute("href").value
#         end
#     end
# end


        

        #価格桁数チェック
        # #4桁以上なら商品の桁数桁数調整
        # #価格の文字列調整だけ最初に実行
        # if search_price.length >= 4 then
        #     search_price = search_price.insert(1, ".")
        # end

        
        #sleep 4

        #国設定用のmodal-windowを操作する
        #国設定用のドロップダウンが表示されるまで待つ→
        #wait.until { driver.find_element(:id, 'shipping_country_id').displayed? }
        ##ドロップダウンメニューをクリック
        #driver.execute_script('document.getElementById("shipping_country_id").click()')
        ##italyをクリック
        #driver.find_element(:xpath, '//*[@id="shipping_country_id"]/option[106]').click
        ##validateボタンをクリック
        #driver.find_element(:xpath, '//*[@id="formShippingCountry"]/div[3]/button').clickputs driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[1]/ul/li[3]/a').displayed?
        
        
        #サイドバーが表示されるまで待つ
        # wait.until { driver.find_element(:id, 'product-sidebar').displayed? }
        #     if search_category == "服" then
        #         driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[3]/a').click
        #     elsif search_category == "靴" then
        #         driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[4]/a').click
                
        #     elsif search_category == "バッグ" then
        #         driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[2]/a').click
                
        #     else
        #         driver.find_element(:xpath, '//*[@id="form-product-filters"]/div[1]/ul/li/ul/li[2]/ul/li[1]/a').click
        #     end
        
        
        
        #商品一覧が表示されるまで待つ
        #wait.until { driver.find_element(:class_name, 'product_list').displayed? }
        #画面下までスライド
        #driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        
        
        
        #商品リスト全体の表示を待つ 動作OK サイズ49獲得！
        # wait.until { driver.find_element(:id, 'items-list').displayed? }
        
        # #doc取得 クロール開始
        # doc = Nokogiri::HTML.parse(driver.page_source)
        # products = doc.css('.product-item')

        
        # #繰り返し処理を追加
        # #ページ数表記が1でなければ繰り返し処理に移行
        # if (doc.css('#pagination').css('li').size != 1) then
            
        #     #クローリングしたurlを記憶しておく空の配列を用意
        #     crawled_urls = []
        #     #最初の1ページ目のurlを代入
        #     crawled_urls.push(brand_home_url)
        #     #変数を作っておく
        #     next_page_url = ""
            
        #     #クロールしたURLが重複しない限りは続行
        #     while (true) do
                
        #         #最後のliのaタグのhrefの値を配列crawled_urlsに代入するために取得する
        #         wait.until { driver.find_element(:id => "pagination").displayed?}
        #         next_page_url = doc.css('#pagination').css('li').last.css('a').attribute('href')
                

        #         #右矢印をクリックするためにid=paginationの要素まで移動する 一度一番したまで降りたあと少し上に移動
        #         driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        #         driver.execute_script("window.scrollBy(document.body.scrollHeight, -300);")

        #         #次ページに行くために「>」をクリック
        #         driver.find_element(:id, 'pagination').find_elements(:tag_name, 'li').last.click
        #         #矢印をクリックして次ページに移動
        #         sleep 2
        #         doc = Nokogiri::HTML.parse(driver.page_source)
        #         if (配列の中に同じURLがあるなら) then
        #             break
        #         else
        #             #もう一回クロールする
        #             bernardelli_one_time_crawl(doc, search_price)
        #         end

        #         #配列にurlを追加
        #         crawled_urls.push(next_page_url)
        #     end

        #         # if (next_page_url.size == 2)
        #         #     #2番目の方のURLを次のページのクロールurlとする
        #         #     next_page_url = next_page_url[1].attribute('href')
        #         # else
        #         #     #先頭のURLを次のページのクロールurlとする
        #         #     next_page_url = next_page_url[0].attribute('href')
        #         # end

        #     end

        # end

        # #価格一致判定処理
        # products.each do |product|
        # #商品価格の表示を待つ
        # product_price = product.css('.product-item-price').inner_text
        #     if product_price.include?(search_price) then
        #         #商品価格
        #         #puts product_price.strip
        #         #商品名
        #         #puts product.css(".product-item-title").text.strip
        #         #画像リンク
        #         puts product.css('a').attribute("href").value
        #         #puts "https://www.montiboutique.com/" + product.css('a').attribute("href").value
        #     end
        # end
        


        # #pagerが存在しているなら繰り返し処理へ
        # if (!doc.css('.pager').empty?) then
            
        #     #css('.next')の中身が空になるまで何度も処理を実行
        #     until (doc.css('.next').empty?) do
                
        #         #nextボタンをクリック
        #         wait.until { driver.find_element(:class => "next").displayed?}
        #         driver.find_element(:class, "next").click
        #         sleep 0.5
                
        #         #次のページの商品リスト欄が表示されるまでまつ
        #         wait.until { driver.find_element(:class => "products-list").displayed?}
        #         #ページソース取得
        #         doc = Nokogiri::HTML.parse(driver.page_source)                
        #         #クローリングする
        #         monti_one_time_crawl(doc, search_price)
        #     end
        # end



        #puts driver.find_elements(:class, 'next').size >= 1
        #nextクラスは2つある
        

        #nextクラスの要素を変数に代入
        # nexts = driver.find_elements(:class, 'next')

        # #puts nexts[1].css('li').size
        # #each文で回す
        # nexts.each do |ne|
        #     #puts ne.find_elements(:tag_name, 'a').size
        #     puts ne.attribute('href')
        # end

        # driver.find_elements(:class, 'next')[1].click
        

        
        #商品情報が全て表示されるまで待つ
        #sleep 8
        #念の為wait処理も記述する記述記述しておく
        #wait.until { driver.find_element(:class_name, 'price').displayed? }
        #wait.until { driver.find_element(:tag_name, 'h5').displayed? }
        #wait.until { driver.find_element(:class, 'product_img_link').displayed? }
        
        #docを取得
        #doc = Nokogiri::HTML.parse(driver.page_source)
        
        # #4桁以上なら商品の桁数桁数調整
        # #価格の文字列調整だけ最初に実行
        # if search_price.length >= 4 then
        #     search_price = search_price.insert(1, ".")
        # end
        
        # #1回クローリングする
        # monti_one_time_crawl(doc, search_price)

        # #pagerが存在しているなら繰り返し処理へ
        # if (!doc.css('.pager').empty?) then
            
        #     #css('.next')の中身が空になるまで何度も処理を実行
        #     until (doc.css('.next').empty?) do
                
        #         #nextボタンをクリック
        #         wait.until { driver.find_element(:class => "next").displayed?}
        #         driver.find_element(:class, "next").click
        #         sleep 0.5
                
        #         #次のページの商品リスト欄が表示されるまでまつ
        #         wait.until { driver.find_element(:class => "products-list").displayed?}
        #         #ページソース取得
        #         doc = Nokogiri::HTML.parse(driver.page_source)                
        #         #クローリングする
        #         monti_one_time_crawl(doc, search_price)
        #     end
        # end