require 'rubygems'
require 'nokogiri'
require 'open-uri'


#✓後でページ送り機能を念のため付ける
module SigrunWoehr


    #docを作るためのメソッド
    def sigrun_make_doc(brand_home_url)
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
    def sigrun_onetime_crawl(doc, search_price)
        products = doc.css(".productData")
        if (products.size == 0)
            puts "sigrunには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
            #商品価格を取得する
            product_price = product.css(".price").inner_text
            if product_price.include?(search_price) then
                #商品価格 商品名 画像リンク を取得する
                #puts product_price.strip
                #puts product.css(".description-item").text.strip
                puts product.css('a').attribute("href").value
            end
            end
        end
    end


    #クロールするメソッド
    def sigrun_crawl(brand_home_url, search_price)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        doc = sigrun_make_doc(brand_home_url)
        #puts "doc取得完了"
        #初回クロール
        sigrun_onetime_crawl(doc, search_price)
        #puts "初回クロール終了" 

        #-----------------------ここまでOK----------------------

        #pagination-optionsの要素が空っぽでない場合は次のページのurlを取得する
        if (!doc.css('.pagination-options').empty?)
            
            #nextのa要素が空っぽでないかぎりはクローリングを繰り返す
            while (!doc.css('.next').css('a').empty?) do
                #次のページのURLを取得
                next_page_url = doc.css('.next').css('a').attribute('href')
                #新しいurlでdocを作成
                doc = sigrun_make_doc(next_page_url)
                #クローリングする
                sigrun_onetime_crawl(doc, search_price)

            end
        end

    end
end