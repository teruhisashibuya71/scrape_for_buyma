require 'rubygems'
require 'nokogiri'
require 'open-uri'


#特記事項
#カテゴリ分けが使えないサイト

module Mycompanero

    #docを作るためのメソッド
    def mycompanero_make_doc(brand_home_url)
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
    def mycompanero_onetime_crawl(doc, search_price)
        products = doc.css('.ajax_block_product')
        if (products.size == 0)
            puts "mucompaneroには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格の有無を確認
                if (product.css('.regular-price').empty?) then
                    #セール価格の表記が無いなら定価を比較対象に取得
                    product_price = product.css('.price').inner_text
                else
                    #セール価格の表記があるならregular_priceを比較対象として取得
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
    def mycompanero_crawl(brand_home_url, search_price)
        #免税価格に調整
        #duty_free_price = search_price.to_i / 1.2
        #duty_free_price = duty_free_price.round.to_s

        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ",")
        end

        doc = mycompanero_make_doc(brand_home_url)
        #puts "doc取得完了"
        #初回クロール
        mycompanero_onetime_crawl(doc, search_price)
        #puts "初回クロール終了" 

        #page-list要素が空っぽでなければ繰り返し処理へ入る
        if (!doc.css('.page-list').empty?)
            
            current_page_url = brand_home_url
            next_page_url = ""
ctime = 1
            #現在のURLと次のページのURLが異なるうちは処理を繰り返す
            #while (current_page_url != next_page_url) do
            while (true) do
                #次のページのURLを取得するまえにページurlを代入
                #current_page_url = next_page_url

                #次のページのURLを取得
                puts next_page_url = doc.css('.next').css('a').attribute('href')
                
                if (next_page_url.nil?) then
                    break
                end
                #新しいurlでdocを作成
                doc = mycompanero_make_doc(next_page_url)
                #クローリングする
                mycompanero_onetime_crawl(doc, search_price)
                ctime = ctime += 1 
                #puts "クローリング回数" + ctime.to_s
                
            end
        end
    end
end