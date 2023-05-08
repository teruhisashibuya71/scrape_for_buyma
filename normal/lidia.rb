require 'rubygems'
require 'nokogiri'
require 'open-uri'

#特記事項
#カテゴリ分けが使えないサイト

module Lidia
    #docを作るためのメソッド
    def lidia_make_doc(brand_home_url)
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
    def lidia_onetime_crawl(doc, search_price)
        products = doc.css('.product')
        if (products.size == 0)
            puts "lidiaには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格あっても取得可能
                product_price = product.css('.price').inner_text
                if (product_price.include?(search_price)) then
                    #商品価格
                    #puts product_price.strip
                    #商品名
                    #puts product.css('.category').text.strip
                    #画像リンク
                    puts "https://www.lidiashopping.com/" + product.css('a').attribute("href").value
                end
            end
        end
    end


    #クロールするメソッド
    def lidia_crawl(brand_home_url, search_price)
        #免税価格に調整
        #duty_free_price = search_price.to_i / 1.2
        #duty_free_price = duty_free_price.round.to_s

        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        doc = lidia_make_doc(brand_home_url)
        #初回クロール
        lidia_onetime_crawl(doc, search_price)

        #page-list要素が空っぽでなければ繰り返し処理へ入る
        if (!doc.css('.bottom-pagination').empty?)
            
            #nextクラスの要素ががからっぽになるまでは繰り返しクローリングする
            while (!doc.css('.next').empty?) do
                
                #次のページのURLを取得
                next_page_url = "https://www.lidiashopping.com/" + doc.css('.next').css('a').attribute('href')
                
                #新しいurlでdocを作成
                doc = lidia_make_doc(next_page_url)

                #クローリングする
                lidia_onetime_crawl(doc, search_price)

            end
        end
    end
end