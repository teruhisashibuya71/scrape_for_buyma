require 'rubygems'
require 'nokogiri'
require 'open-uri'

#nokogiri
#免税表示/四捨五入
#サイト更新後も動作良好

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
    def mycompanero_onetime_crawl(doc, duty_free_price)
        products = doc.css('.ajax_block_product')
        if (products.size == 0)
            puts "mycompaneroには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格の有無を確認
                if (product.css('.regular-price').empty?) then
                    #セール価格の表記が無いなら定価を比較対象に取得
                    product_price = product.css('.price').inner_text.strip.to_s.gsub(/[[:space:]]/,"")
                else
                    #セール価格の表記があるならregular_priceを比較対象として取得
                    product_price = product.css('.regular-price').inner_text.strip.to_s.gsub(/[[:space:]]/,"")
                end
                #puts product_price = product.css('.regular-price').inner_text.strip
                if (product_price.include?(duty_free_price)) then
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
        #免税価格に調整 四捨五入
        duty_free_price = search_price.to_i / 1.2
        duty_free_price = duty_free_price.round.to_s

        #初回クローリング
        doc = mycompanero_make_doc(brand_home_url)
        mycompanero_onetime_crawl(doc, duty_free_price)
        
        #page-list要素が空っぽでなければ繰り返し処理へ入る
        if (!doc.css('.page-list').empty?)
        
            #必要な入れ物一式を用意する
            crawled_urls = []
            current_page_url = brand_home_url.to_s
            crawled_urls.push(current_page_url)
            next_page_url = ""

            while (true) do
                #次のクロール対象となるURLを取得
                next_page_url = doc.css(".page-list li").last.css('a').attribute('href').to_s
                #クロールしたurl配列の中に、次のページのurlが入っているなら繰り返し処理を抜けて処理を終える
                if (crawled_urls.include?(next_page_url)) then
                    break
                end
                #新しいurlでdocを作成
                doc = mycompanero_make_doc(next_page_url)
                #クローリングする
                mycompanero_onetime_crawl(doc, duty_free_price)
                #クロール済みとなったurlを配列に入れる
                crawled_urls.push(next_page_url.to_s)
            end
        end
    end
end