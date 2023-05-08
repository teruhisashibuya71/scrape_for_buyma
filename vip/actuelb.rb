require 'rubygems'
require 'nokogiri'
require 'open-uri'


#特記事項
#カテゴリ分けが使えないサイト

module Actuelb

    #docを作るためのメソッド
    def actuel_make_doc(brand_home_url)
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
    def actuel_onetime_crawl(doc, search_price)
        products = doc.css('.js-product-miniature-wrapper')
        if (products.size == 0)
            puts "actuel-Bには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格の有無を確認
                if (product.css('.regular-price').empty?) then
                    product_price = product.css('.product-price').inner_text
                else
                    product_price = product.css('.regular-price').inner_text
                end
                if (product_price.include?(search_price)) then
                    #商品価格 商品名 画像リンク を取得する
                    #puts product_price.strip
                    #puts product.css(".description-item").text.strip
                    puts product.css('a').attribute("href").value
                end
            end
        end
    end


    #クロールするメソッド
    def actuel_crawl(brand_home_url, search_price)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ",")
        end

        doc = actuel_make_doc(brand_home_url)
        #puts "doc取得完了"
        #初回クロール
        actuel_onetime_crawl(doc, search_price)
        #puts "初回クロール終了" 

        #ページ送り要素があれば繰り返し判断に突入
        # if (!doc.css('.pagination--container').empty?)
        #     #page = 1
        #     #spanサイズが2で spanテキストがPrevになるまではクローリングを繰り返す
        #     while (doc.css('.body__text--breadcrumb').css("span").size != 2 || doc.css('.body__text--breadcrumb').css("span")[0].text != "Prev") do
        #     #until (doc.css('.body__text--breadcrumb').css("span").size == 2 && doc.css('.body__text--breadcrumb').css("span")[0].text == "Prev") do
        #         #次のページのURLを取得
        #         #puts page = page += 1
        #         urls = doc.css('.pagination--container').css('.tertiary__color').css('a')
        #         if (urls.size == 1)
        #             next_page_url = "https://actuel.lu/" + urls.attribute('href')
        #         else
        #             next_page_url = "https://actuel.lu/" + urls[1].attribute('href')
        #         end

        #         #新しいurlでdocを作成
        #         doc = actuel_make_doc(next_page_url)
        #         #クローリングする
        #         actuel_onetime_crawl(doc, search_price)

        #     end
        # end
    end
end