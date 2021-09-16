require 'rubygems'
require 'nokogiri'
require 'open-uri'


#特記事項
#カテゴリ無しのサイト

module Dafne

    #docを作るためのメソッド
    def dafne_make_doc(brand_home_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(brand_home_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #初回クロール
    def dafne_onetime_crawl(doc, search_price, brand_home_url)
        products = doc.css('.ProductItem')
        if (products.size == 0)
            puts "dafneには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格あっても取得可能
                product_price = product.css('.ProductItem__PriceList').inner_text
                if (product_price.include?(search_price)) then
                #if (product_price.include?(search_price)) then
                    #商品価格
                    #puts product_price.strip
                    #商品名
                    #puts product.css('.ProductItem__Title').text.strip
                    #画像リンク
                    puts "https://www.dafneshop.it" + product.css('a').attribute("href").value
                end
            end
        end
    end


    #クロールするメソッド
    def dafne_crawl(brand_home_url, search_price)

        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ",")
        end
        
        #doc作成と初回クロール
        doc = dafne_make_doc(brand_home_url)
        dafne_onetime_crawl(doc, search_price, brand_home_url)
        
        #マルニの取り扱いやめるっぽいので繰り返し処理無し
        
    end
end