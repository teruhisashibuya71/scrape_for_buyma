require 'rubygems'
require 'nokogiri'
require 'open-uri'


#特記事項
#カテゴリ分けが使えないサイト

module Julian

    #docを作るためのメソッド
    def julian_make_doc(brand_home_url)
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
    def julian_onetime_crawl(doc, search_price, brand_home_url, lower_search_price, higher_search_price)
        products = doc.css('.product')
        if (products.size == 0)
            puts "julianには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格あっても取得可能
                product_price = product.css('.price').inner_text
                if (product_price.include?(search_price) || product_price.include?(lower_search_price) || product_price.include?(higher_search_price)) then
                    #puts product_price.strip
                    #puts product.css('.name').text.strip
                    puts "https://www.julian-fashion.com/" + product.css('a').attribute("href").value
                end
            end
        end
    end


    #クロールするメソッド
    def julian_crawl(brand_home_url, search_price)

        #価格が微妙に低いケースがある
        lower_search_price = search_price.to_i - 1
        lower_search_price = lower_search_price.to_s

        higher_search_price = search_price.to_i + 1
        higher_search_price = higher_search_price.to_s

        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")

            #1€違いの数値にも同様にドットを代入
            if 4 <= lower_search_price.length then
                lower_search_price = lower_search_price.insert(1, ".")
            end
            if 4 <= higher_search_price.length then
                higher_search_price = higher_search_price.insert(1, ".")
            end

        end
        
        #doc作成と初回クロール
        doc = julian_make_doc(brand_home_url)
        julian_onetime_crawl(doc, search_price, brand_home_url, lower_search_price, higher_search_price)

        #pager要素が空っぽでなければ繰り返し処理へ
        if (!doc.css('.pager').empty?)
            
            #nextクラスの要素ががからっぽになるまでは繰り返しクローリングする
            while (!doc.css('.next').empty?) do
                
                #次のページのURLを取得
                next_page_url = brand_home_url + doc.css('.next').css('a').attribute('href')
                
                #新しいurlでdocを作成
                doc = julian_make_doc(next_page_url)

                #クローリングする
                julian_onetime_crawl(doc, search_price, brand_home_url, lower_search_price, higher_search_price)

            end
        end
    end
end