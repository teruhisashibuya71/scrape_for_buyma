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


module Bernardelli

    #初回クロール
    def bernardelli_onetime_crawl(doc, search_price)
        products = doc.css('.product-item')
        if (products.size == 0)
            puts "bernardelliには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格あっても取得可能
                product_price = product.css('.product-item-price').inner_text
                if (product_price.include?(search_price)) then
                    #puts product_price.strip
                    #puts product.css('.product-item-title').text.strip
                    puts product.css('a').attribute("href").value
                end
            end
        end
    end


    #クロールするメソッド
    def bernardelli_crawl_selenium(brand_home_url, search_price)

        #ヘッドレス
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        wait = Selenium::WebDriver::Wait.new(timeout: 30)
        driver.manage.window.resize_to(1800,1200)
        driver.get(brand_home_url)

        #通常
        # driver = Selenium::WebDriver.for :chrome
        # wait = Selenium::WebDriver::Wait.new(timeout: 30)
        # driver.manage.window.resize_to(1300,1000)
        # driver.get(brand_home_url)

        #商品価格の桁数調整無しで良い
        
        #商品リスト全体の表示を待つ
        #sleep 4
        wait.until { driver.find_element(:id, 'items-list').displayed? }

        #cookieウインドウの表示があるならOKを押して消す
        if (driver.find_elements(:id, 'CybotCookiebotDialog').size != 0) then
            driver.execute_script('document.getElementById("CybotCookiebotDialogBodyLevelButtonLevelOptinAllowallSelection").click()')
        end

        #クーポン表示があるなら消す
        if (driver.find_elements(:class, 'modal-promo-close').size != 0) then
            driver.execute_script('document.getElementsByClassName("modal-promo-close")[0].click()')
        end

        #doc作成と初回クロール
        doc = Nokogiri::HTML.parse(driver.page_source)
        bernardelli_onetime_crawl(doc, search_price)

        
        
        #ページ数表示が1でなければ繰り返し処理へ id=pagination
        if (doc.css('#pagination').css('li').size != 1)

            #クッキーウインドウがあれば消去する

            #割引バナーが表示されているなら削除 出るまで最大8秒待つ 出ないなら次の処理へ(elemtentsの効果)
            if (driver.find_elements(:id, 'CybotCookiebotDialog').size != 0) then
                driver.execute_script('document.getElementById("CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll").click()')
            end

            #クローリングしたurlを記憶しておく空の配列を用意
            crawled_urls = []
            #最初の1ページ目のurlを代入
            crawled_urls.push(brand_home_url)
            #変数を作っておく
            next_page_url = ""

            #2回目からは免税価格にする
            duty_free_price = search_price.to_i / 1.22
            duty_free_price = duty_free_price.floor.to_s

            
            #nextクラスの要素ががからっぽになるまでは繰り返しクローリングする
            while (true) do

                #次のページのURLを取得 最後のliのa.href waitはページが切り替わった時のために毎回必要となる
                wait.until { driver.find_element(:id => "pagination").displayed?}
                next_page_url = doc.css('#pagination').css('li').last.css('a').attribute('href')
                
                #クロール対象のurlはStringに変更して配列に代入しないと重複チェックが機能しない
                next_page_url = next_page_url.to_s
                crawled_urls.push(next_page_url)

                #一番下までスライドしてから少し上にスクロールして「>」マークを画面内にとらえる
                driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                sleep 3
                driver.execute_script("window.scrollBy(document.body.scrollHeight, -500);")

                #「>」をクリック paginationの表示確認とっているのでwait無し
                driver.find_element(:id, 'pagination').find_elements(:tag_name, 'li').last.click

                #sleep 1

                #商品リスト全体の表示を待ってからdocを作成
                #sleep 4
                wait.until { driver.find_element(:id, 'items-list').displayed? }
                doc = Nokogiri::HTML.parse(driver.page_source)

                #クロール直前に対象のURLの重複チェックを実行 重複していたら終了
                if ((crawled_urls.count - crawled_urls.uniq.count) > 0) then
                    break
                else
                    #重複がなければクローリングする
                    bernardelli_onetime_crawl(doc, duty_free_price)
                end
            end
        end
    end
end