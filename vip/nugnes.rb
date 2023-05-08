
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#完成！
module Nugnes

    #docを作るためのメソッド
    def nugnes_make_doc(attack_site_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(attack_site_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    def nugnes_onetime_crawl(attack_site_url, nugnes_search_price, doc)
        doc.css('.product-card').each do |node|
            #商品価格を取得する  価格が同じなら商品名とリンクURLを取得する
            item_price = node.css(".money").inner_text
            #もし価格が同じなら
            if item_price.include?(nugnes_search_price) then
                #商品価格 商品名 画像リンク を取得する
                #puts item_price
                #puts node.css("h4").inner_text
                relative_product_url = node.css('a').attribute("href").value #フルurlが取得される
                puts "https://nugnes1920.com" + relative_product_url
            end
        end
    end

    #クロールするメソッド
    def nugnes_crawl(attack_site_url, search_price)
        #価格の文字列調整だけ最初に実行
        if 4 <= search_price.length then
            search_price = search_price.insert(1, ".")
        end
        doc = nugnes_make_doc(attack_site_url)
        nugnes_onetime_crawl(attack_site_url, search_price, doc)
        #もしnextボタンがあるなら、nextが押せなくなるまでクロールを続ける
        #条件式がfalseの間は繰り返す → OOになるまでは..とも言える 今回はリンクurlがnilになるまでは
        until doc.css('.next').css('a').attribute("href").nil? do
            #次のページのURLを取得
            relative_url = doc.css('.next').css('a').attribute("href")
            attack_site_url = "https://nugnes1920.com" + relative_url
            #docを詰め替える
            doc = nugnes_make_doc(attack_site_url)
            #クローリングする
            nugnes_onetime_crawl(attack_site_url, search_price, doc)
        end
    end
end