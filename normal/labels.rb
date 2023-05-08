#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#繰り返し条件 = ページネーションの最後の要素 hrefが null(nil)になるまで
#ページネーションの最後のリンクをクリック
#価格取得 セール価格の有無で取得要素を変更

module Labels

    def labels_onetime_crawl_selenium(doc, search_price)
        products = doc.css('.card-wrapper')
        products.each do |product|
            #メンテナンス性を意識して対象の商品価格の方からドットやコンマを取り除く
            #定価は2つある class = .price-item--regular の後ろの方にはいる
            #puts item_price = product.css('.price-item--regular').last.inner_text.delete(".")
            #puts item_price = product.css('.price__sale').css('price-item')
            #定価とセール価格の2つを取得
            #item_prices = product.css('.price__sale').css('price-item').inner_text.delete(".")
            
            #セール品の価格は取得できた
            #puts product.css('.price__sale').css('.price-item--regular')
            # puts product.css(".caption-with-letter-spacing")
            # puts product.css(".caption-with-letter-spacing")
            if (product.at_css('.price__sale').at_css('.price-item--regular').inner_text.include?("€")) then
                #puts product.css('.price__sale').css('.price-item--regular').inner_text
                #対象はセール品
                if (product.at_css('.price__sale').at_css('.price-item--regular').inner_text.delete(".").include?(search_price)) then
                    #puts item_price 
                    #puts product_name = product.css('h5').inner_text
                    puts "https://labelsfashion.com/" + product.css('a').attribute("href").value
                end
            else
                #puts product.css('.price__sale').css('.price-item--last').inner_text
                #対象は定価品
                if (product.at_css('.price__sale').at_css('.price-item--last').inner_text.delete(".").include?(search_price)) then
                    #puts item_price 
                    #puts product_name = product.css('h5').inner_text
                    puts "https://labelsfashion.com/" + product.css('a').attribute("href").value
                end
            #if (product.at_css('.price__sale').css('price-item--regular').nil?) then
            #    puts "セール品"
            #else
            #    puts "定価品"
            ##if (item_price.include?(search_price)) then
            #    #puts item_price 
            #    #puts product_name = product.css('h5').inner_text
            ##    puts "https://labelsfashion.com/" + product.css('a').attribute("href").value
            end
        end
    end

    def labels_crawl_selenium(brand_home_url, search_price)
        #ノーマル
        #driver = Selenium::WebDriver.for :chrome
        #ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        driver.manage.window.resize_to(1300,1000)
        driver.get(brand_home_url)

        #商品価価格の桁数調整は「onetime_crawl_selenium」内部で行う

        #国の切り替えボタンが表示されるまで待つ
        wait.until { driver.find_element(:class => "disclosure").displayed? }
        #driver.find_element(:class, 'disclosure').location_once_scrolled_into_view
        driver.execute_script('window.scroll(0,10000);')

        #ボタンをクリック
        driver.find_elements(:class, 'disclosure__button')[0].click
        #xpath指定だと何故か unable locate element エラーが生じてしまう
        #driver.find_element(:xpath, '/html/body/div[4]/footer/div[2]/div/div[1]/localization-form[1]/form/div/div/button').click

        #オランダ発送に切り替える
        element = driver.find_element(:id, "FooterCountryList")

        #中身の要素をクリックしてみる
        driver.action.move_by(element.location.x + 20, element.location.y + 20)

        #国選択ウインドウをスクロールしてオランダをクリック
        driver.execute_script('document.getElementsByClassName("disclosure__item")[146].scrollIntoView();')
        driver.find_elements(:class, 'disclosure__item')[147].click

        #商品が表示されるまで待つ
        wait.until { driver.find_element(:id => "product-grid").displayed? }

        #pagination__listクラスが存在するなら繰り返し処理を実行する
        if (driver.find_elements(:class, 'pagination__list').size >= 1) then
            doc = Nokogiri::HTML.parse(driver.page_source)
            #最後のaタグのhref属性が空欄になるまで処理を繰り返す
            #要素hrefが存在しない場合はnullではなく空欄となる
            until (doc.css('.pagination__list').css('li').last.css('a').attribute("href").nil?) do
                labels_onetime_crawl_selenium(doc, search_price)
                #puts driver.current_url
                
                #次ページ移動用のリンクをクリック
                driver.find_elements(:class, 'pagination__item').last.click

                #商品が表示されるまで待ち、docを詰め替える
                wait.until { driver.find_element(:id => "product-grid").displayed? }
                doc = Nokogiri::HTML.parse(driver.page_source)
            end
            #最後に一度クローリングして終了
            #puts driver.current_url
            labels_onetime_crawl_selenium(doc, search_price)
        else
            #ページネーションがない場合は1度だけクロール
            doc = Nokogiri::HTML.parse(driver.page_source)
            labels_onetime_crawl_selenium(doc, search_price)
        end
    end
end