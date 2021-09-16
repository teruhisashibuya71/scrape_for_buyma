require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module Credoman

    def credoman_onetime_crawl(doc, search_price)
        products = doc.css('.item')
        products.each do |product|
            item_price = product.css('.priceOffer').inner_text
            if (item_price.include?(search_price)) then
                #puts item_price 
                #puts product_name = product.css('name').inner_text
                product_url = "https://www.credomen.com" + product.css(".itemImg").css('a').attribute("href").value
                if (product_url.include?(" ")) then
                    puts product_url.gsub(/\s/, '%20') #感覚スペースを削除または置き換え
                else
                    puts product_url
                end
            end
        end
    end

    def credoman_crawl_selenium(brand_home_url, search_price)
    
        #注意事項
        #1.価格桁調整は必要無し

        #ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options
        #ノーマル↓
        #driver = Selenium::WebDriver.for :chrome
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)
        
        sleep 1
        
        #商品リストが表示されるまで待つ
        wait.until { driver.find_element(:id, 'overview').displayed? }
        
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        driver.execute_script("window.scrollBy(document.body.scrollHeight, -600);")

        #初回doc作成
        doc = Nokogiri::HTML.parse(driver.page_source)
        
        #we are very sorry対策
        if (doc.css(".item").size == 0) then
            puts "credomanのページ読み込みでエラーが生じました。手動で確認してください"
        else
            #page数を取得
            page_amount = doc.css('.pagination').css('li').size
            if (page_amount == 2) then                                #ページ数が2の時処理 ページ1とページ2しか無い場合
                credoman_onetime_crawl(doc, search_price)              #初回クロール
                driver.find_elements(:class, 'pageNumber').last.click #ページ2を押して移動
                sleep 4                                               #商品が表示されるまで待つしかない...
                doc = Nokogiri::HTML.parse(driver.page_source)        #doc再取得
                credoman_onetime_crawl(doc, search_price)              #2ページ目をクロールして終了
            elsif (page_amount > 2) #ページ数が2以上の時
                crawl_times = doc.css('.pagination').css('.firstLast').inner_text.to_i #lastクラスのinner_textを取得して代入→数字
                page_index = 0 #page_index = 0を用意
                break_index = 0 #page_index = 0を用意
                crawl_times.times do #その数字をもとに繰り返し処理の回数を指定 times構文
                    credoman_onetime_crawl(doc, search_price) #初回クロール
                    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                    driver.execute_script("window.scrollBy(document.body.scrollHeight, -600);")
                    page_index += 1  #クリックするページ番号を指定する番号
                    break_index += 1  #クリックするページ番号を指定する番号
                    puts "#{page_index}" + "回目のクロール終了"
                    #繰り返し処理の最後の1回はクリックするページが無いのでbreak
                    if (crawl_times == break_index)
                        break
                    else
                        driver.find_elements(:class, "pageNumber")[page_index].click #indexをもとにページ番号をクリックして次のページへ
                        sleep 8
                        doc = Nokogiri::HTML.parse(driver.page_source) #再度docを取得
                    end
                end
            else #ページ数が1の時の処理
                credoman_onetime_crawl(doc, search_price) #初回クロール 
            end
        end
    end
end