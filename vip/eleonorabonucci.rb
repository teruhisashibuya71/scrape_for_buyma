require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'


module Eleonorabonucci

    #docを作るためのメソッド
    def eleonorabonucci_make_doc(attack_site_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(attack_site_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end
    
    def eleonorabonucci_one_time_crawl(doc, search_price)
        if (doc.css(".product").size == 0) then
            puts "eleonorabonucciに対象のカテゴリーの商品はありません"
        else
            doc.css(".product").each do |node|
                #商品価格を取得する
                item_price = node.css(".product-price ins").inner_text
                #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
                if item_price.include?(search_price) then
                    #puts item_price
                    #puts node.css(".product-description h4").inner_text
                    puts "https://eleonorabonucci.com/" + product_url = node.css(".product-image").css('a').attribute("href").value
                end
            end
        end
    end

    def eleonorabonucci_crawl(attack_site_url, search_price)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ",")
        end
        
        #クロール開始
        doc = eleonorabonucci_make_doc(attack_site_url)
        eleonorabonucci_one_time_crawl(doc, search_price)        
        
        #>>が画面上に表示されている場合は繰り返し処理へ入る
        if (doc.css("#MainContent_hlLastPage").size == 1) then
            #while 条件が正の場合は繰り返す → #MainContent_hlLastPageの要素があるうちは繰り返す
            while (doc.css("#MainContent_hlLastPage").size == 1) do
                next_page_url = "https://eleonorabonucci.com/" + doc.css('#MainContent_hlLastPage').attribute("href")
                attack_site_url = next_page_url
                #docを詰め替える
                doc = eleonorabonucci_make_doc(attack_site_url)
                #再度クローリングする
                eleonorabonucci_one_time_crawl(doc, search_price)
            end
        end
    end
end