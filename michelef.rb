require 'rubygems'
require 'nokogiri'
require 'open-uri'


#特記事項
#カテゴリ分けが使えないサイト

module Michelefranzese

    #docを作るためのメソッド
    def michele_make_doc(brand_home_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(brand_home_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #gbと一緒 1回だけクロール
    def michele_onetime_crawl(doc, search_price)
        products = doc.css('.item')
        if (products.size == 0)
            puts "micheleには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格あっても取得可能
                product_price = product.css('.prezzo').inner_text
                if (product_price.include?(search_price)) then
                    #商品価格
                    #puts product_price.strip
                    #商品名
                    #puts product.css('.prodotto').text.strip
                    #画像リンク
                    puts product.css('a').attribute("href").value
                end
            end
        end
    end


    #クロールするメソッド
    def michele_crawl(brand_home_url, search_price)
        
        #商品価格の桁数調整の必要無し

        doc = michele_make_doc(brand_home_url)
        #初回クロール
        michele_onetime_crawl(doc, search_price)
        
        #paginate内部のaタグの数は0でなければ繰り替えし処理に入る
        if (doc.css('.paginazione').css('a').size != 0)
        
            #クローリングしたurlを記憶しておく空の配列を用意
            crawled_urls = []
            #最初の1ページ目のurlを代入
            crawled_urls.push(brand_home_url)
            #変数を作っておく
            next_page_url = ""
            
            #配列の中に同じURLが無い限りはクローリングをくりかえす
            while (true) do
                
                #次のページのURLリストを取得
                next_page_url = doc.css('.paginazione').css('a')
                if (next_page_url.size == 2)
                    #2番目の方のURLを次のページのクロールurlとする
                    next_page_url = next_page_url[1].attribute('href')
                else
                    #先頭のURLを次のページのクロールurlとする
                    next_page_url = next_page_url[0].attribute('href')
                end
                
                #新しいurlでdocを作成
                doc = michele_make_doc(next_page_url)

                #Stringに変更して代入しないと重複チェックが機能しない
                next_page_url = next_page_url.to_s
                crawled_urls.push(next_page_url)

                #クロール直前に重複チェックを実行
                if ((crawled_urls.count - crawled_urls.uniq.count) > 0) then
                    break
                else
                    #クローリングする
                    michele_onetime_crawl(doc, search_price)
                end
            end
        end
    end
end