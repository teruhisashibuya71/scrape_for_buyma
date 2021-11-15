require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'


module Amr

    #docを作るためのメソッド
    def amr_make_doc(brand_home_url)
        charset = nil
        html = URI.open(brand_home_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    
    def amr_onetime_crawl(doc, search_price)
        products = doc.css('.product-grid-item')
        products.each do |product|
            #商品価格を取得する
            product_price = product.css('.product-price').inner_text
            if (product_price.include?(search_price)) then
                #商品価格
                #puts product_price.strip
                #商品名
                #puts product.css('.product-item-link').text.strip
                #画像リンク
                puts "https://amrstore.com/" + product.css('a').attribute("href").value
            end
        end
    end
    
    #クロールするメソッド
    def amr_crawl(brand_home_url, search_price)
        
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ",")
        end

        #doc作成と商品の有無をチェック
        doc = amr_make_doc(brand_home_url)
        if (doc.css('.product-grid-item').size == 0)
            puts "amrには該当ブランドの商品が現在ありません"
        else
            #初回クロール
            amr_onetime_crawl(doc, search_price)
            #ページ送り要素があれば繰り返しへ
            if (doc.css('.pagination-holder').size > 0) then
                #aタグ部分のクラス値にdisabledを含sんでいない限りはクローリングを繰り返す
                atag_class_value = ""
                while (!atag_class_value.include?("disabled")) do
                    #次のページのURLを取得
                    next_page_url = "https://amrstore.com/" + doc.css('.next').css('a').attribute('href')
                    #新しいurlでdocを作成
                    doc = amr_make_doc(next_page_url)
                    #クローリングする
                    amr_onetime_crawl(doc, search_price)
                    #while判定に使用するaタグのクラス値を取得
                    atag_class_value = doc.css('.next').attribute('class').to_s
                end
            end
        end
    end
end