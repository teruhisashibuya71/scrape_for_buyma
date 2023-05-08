require 'rubygems'
require 'nokogiri'
require 'open-uri'

#nokogiri
#日本円表示
#免税表示/四捨五入
#サイト更新後も動作良好

module Ilduomo

    #docを作るためのメソッド
    def ilduomo_make_doc(brand_home_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(brand_home_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #1回だけクロール
    def ilduomo_onetime_crawl(doc, range_price_low, range_price_high)
        products = doc.css('.thumbnail-container')
        if (products.size == 0)
            puts "ilduomoには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する 2番目のspan要素を取得することで常に定価を取得可能
                #puts product_price = product.css('.product-price-and-shipping').nth-child(2).inner_text
                product_price = product.css('.product-price-and-shipping').children[3].inner_text.delete("¥").delete(".").delete(",").chop.chop.to_i
                if product_price.between?(range_price_low,range_price_high) then
                #    #商品価格 商品名 画像リンク を取得する
                #    #puts product_price.strip
                #    #puts product.css(".description-item").text.strip
                    puts product.css('a').attribute("href").value
                end
            end
        end
    end


    #クロールするメソッド
    def ilduomo_crawl(brand_home_url, search_price, currency)
        #為替調整
        adjusted_currency = currency - 1
        #日本円調整処理
        duty_free_price = search_price.to_i / 1.2
        duty_free_price = duty_free_price.round #.to_s
        japanese_yen_price = duty_free_price * adjusted_currency
        japanese_yen_price = japanese_yen_price.floor
        #検索対象価格のレンジを設定
        if (japanese_yen_price >= 300000) then 
            range_price_low = japanese_yen_price - 4000
            range_price_high = japanese_yen_price + 4000 
        elsif (japanese_yen_price >= 100000) then 
            range_price_low = japanese_yen_price - 2500
            range_price_high = japanese_yen_price + 2500  
        else 
            range_price_low = japanese_yen_price - 1500
            range_price_high = japanese_yen_price + 1500
        end

        #初回クローリング
        doc = ilduomo_make_doc(brand_home_url)
        ilduomo_onetime_crawl(doc, range_price_low, range_price_high)
        
        #ilduomo_onetime_crawl(doc, duty_free_price)
        
        #現状商品数が多くても1ページだけのようなので1回で処理を終了する
        #if (!doc.css('.page-list').empty?)
        #
        #    #必要な入れ物一式を用意する
        #    crawled_urls = []
        #    current_page_url = brand_home_url.to_s
        #    crawled_urls.push(current_page_url)
        #    next_page_url = ""
#
        #    while (true) do
        #        #次のクロール対象となるURLを取得
        #        next_page_url = doc.css(".page-list li").last.css('a').attribute('href').to_s
        #        #クロールしたurl配列の中に、次のページのurlが入っているなら繰り返し処理を抜けて処理を終える
        #        if (crawled_urls.include?(next_page_url)) then
        #            break
        #        end
        #        #新しいurlでdocを作成
        #        doc = ilduomo_make_doc(next_page_url)
        #        #クローリングする
        #        ilduomo_onetime_crawl(doc, duty_free_price)
        #        #クロール済みとなったurlを配列に入れる
        #        crawled_urls.push(next_page_url.to_s)
        #    end
        #end
    end
end