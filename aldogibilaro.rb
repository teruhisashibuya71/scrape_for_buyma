require 'rubygems'
require 'nokogiri'
require 'open-uri'


#特記事項
#カテゴリ無し 
#価格表記はドット「.」
#セール価格→
#免税表示22%
#ページ送りあり 1ページでもpage-nation表示



module Aldogibilaro

    #docを作るためのメソッド
    def aldogibilaro_make_doc(brand_home_url)
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
    def aldogibilaro_onetime_crawl(doc, duty_free_price, brand_home_url)
        products = doc.css('.product-miniature')
        if (products.size == 0)
            puts "Aldogibilaroには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格あっても取得可能
                product_price = product.css('.product-price-and-shipping').inner_text
                if (product_price.include?(duty_free_price)) then
                #if (product_price.include?(search_price)) then
                    #商品価格
                    #puts product_price.strip
                    #商品名
                    #puts product.css('.product-title').text.strip
                    #画像リンク
                    puts product.css('a').attribute("href").value
                end
            end
        end
    end


    #クロールするメソッド
    def aldogibilaro_crawl(brand_home_url, search_price)

        #免税処理
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.floor.to_s

        #4商品の桁数調整(免税version)
        if duty_free_price.length >= 4 then
            puts duty_free_price = duty_free_price.insert(1, ".")
        end
        
        #doc作成と初回クロール
        doc = aldogibilaro_make_doc(brand_home_url)
        aldogibilaro_onetime_crawl(doc, duty_free_price, brand_home_url)

        
        #liの数が3でなければ繰り返し処理へ
        if (doc.css('.page-list').css('li').size != 3)

            #クローリングしたurlを記憶しておく空の配列を用意
            crawled_urls = []
            #最初の1ページ目のurlを代入
            crawled_urls.push(brand_home_url)
            #変数を作っておく
            next_page_url = ""
            
            #nextクラスの要素ががからっぽになるまでは繰り返しクローリングする
            while (true) do

                #次のページのURLを取得
                next_page_url = doc.css('.page-list').css('.next').attribute('href')
                
                #新しいurlでdocを作成
                doc = aldogibilaro_make_doc(next_page_url)

                #Stringに変更して配列に代入しないと重複チェックが機能しない
                next_page_url = next_page_url.to_s
                crawled_urls.push(next_page_url)

                #クロール直前に対象のURLの重複チェックを実行 重複していたら終了
                if ((crawled_urls.count - crawled_urls.uniq.count) > 0) then
                    break
                else
                    #クローリングする
                    aldogibilaro_onetime_crawl(doc, duty_free_price, next_page_url)
                end
            end
        end
    end
end