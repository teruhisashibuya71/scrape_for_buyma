#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module Labels

    def labels_crawl_selenium(brand_home_url, search_price)
        #ヘッドレスオプション
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, options: options

        #最大待ち時間を設定
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        #指定のURLにアクセス
        driver.get(brand_home_url)
        
        #商品価価格桁数調整無し

        #最初の商品ボックスの数 初期値2
        doc = Nokogiri::HTML.parse(driver.page_source)
        newest_number_product_wrapper = doc.css('.wrapper').size
        #wrapperボックスの数を代入
        last_number_product_wrapper = 0

        #div class="wrapper"の数が変わらなくなるまで処理を繰り返す
        until (last_number_product_wrapper == newest_number_product_wrapper) do

            #最新のwrapperクラスの数をlast_number_product_wrapperに代入
            last_number_product_wrapper = newest_number_product_wrapper
            
            #一番下までスクーロール
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            sleep 3

            #スクロールした直後のソースを取得
            doc = Nokogiri::HTML.parse(driver.page_source)
            #wrapperクラスの数を再度取得して代入
            newest_number_product_wrapper = doc.css('.wrapper').size
            
        end

        #スクロールしきったあとで商品情報を取得
        products = doc.css('.product-item')
        products.each do |product|
            product_price = product.css('.price-wrapper').inner_text
            if product_price.include?(search_price) then
                #商品価格
                #puts product_price.strip
                #商品名
                #puts product.css(".product-item-link").text.strip
                #画像リンク
                puts product.css('a').attribute("href").value
            end
        end
    end
end