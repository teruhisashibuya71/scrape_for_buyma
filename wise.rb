require 'rubygems'
require 'nokogiri'
require 'open-uri'


#✓後でページ送り機能を念のため付ける
module Wise

    ##docを作るためのメソッド
    #def wise_make_doc(brand_home_url)
    #    options = Selenium::WebDriver::Chrome::Options.new
    #    options.add_argument('--headless')
    #    driver = Selenium::WebDriver.for :chrome, options: options
    #    driver.navigate.to brand_home_url
    #    wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
    #    wait.until { driver.find_element(:class => "scolumns").displayed? }
    #    return driver
    #end

    #docを作るためのメソッド
    def wise_make_doc(brand_home_url)
        #スクレイピング開始する
        charset = nil
        html = open(brand_home_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end


    def wise_onetime_crowl(wise_search_price, doc)
        doc.css(".item").each do |product|
            #商品価格を取得する
            item_price = product.css(".price").inner_text
            if item_price.include?(wise_search_price) then
                #商品価格 商品名 画像リンク を取得する
                puts item_price.strip
                puts product.css(".description-item").text.strip
                puts product.css('a').attribute("href").value
            end
        end
    end
    
    #クロールするメソッド
    def wise_crawl(brand_home_url, search_price)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
        #初回クロール
        doc = wise_make_doc(brand_home_url)
        wise_onetime_crowl(search_price, doc)

        #ページ送り機能 unless文は条件式が falseの場合に繰り返す labelクラスの中身が空っぽでなかればクローリングする
        unless doc.css(".next").empty? then
            #次のページのURLを取得
            next_page_url = doc.css(".next").css("a").attribute("href")
            #新しいurlでdocを作成
            doc = wise_make_doc(next_page_url)
            #クローリングする
            wise_onetime_crowl(search_price, doc)
        end
    end
end