require 'rubygems'
require 'nokogiri'
require 'open-uri'


#特記事項
#カテゴリ分けが使えないサイト

module LuisaWorld

    #docを作るためのメソッド
    def luisa_make_doc(brand_home_url)
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
    def luisa_onetime_crawl(doc, search_price)
        products = doc.css('.box')
        products.each do |product|
            #商品価格を取得する
            #セール価格あっても取得可能
            product_price = product.css('.price').inner_text
            if (product_price.include?(search_price)) then
                #商品価格
                #puts product_price.strip
                #商品名
                #puts product.css('.product-titele').text.strip
                #画像リンク
                puts product.css('a').attribute("href").value
            end
        end
    end

    #クロールするメソッド
    def luisa_crawl(brand_home_url, search_price)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ",")
        end
        #doc作成と商品の有無をチェック
        doc = luisa_make_doc(brand_home_url)
        if (doc.css('.product-small').size == 0)
            puts "luisaWorldには該当ブランドの商品が現在ありません"
        else
            luisa_onetime_crawl(doc, search_price)
            #ページ送り要素が空っぽでなければ繰り返し処理へ
            unless (doc.css('.nav-pagination').empty?) then
                #nextクラスの要素ががからっぽでなければ繰り返しクローリングする
                until (doc.css('.next').empty?) do
                    #次のページのURLを取得
                    next_page_url = doc.css('.next').css('a').attribute('href')
                    #新しいurlでdocを作成
                    doc = luisa_make_doc(next_page_url)
                    #クローリングする
                    luisa_onetime_crawl(doc, search_price)
                end
            end
        end
    end
end