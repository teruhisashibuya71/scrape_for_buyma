require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#✔ページ送り機能
module Coltorti

    #docを作るためのメソッド
    def coltorti_make_doc(attack_site_url)
        #スクレイピング開始する
        charset = nil
        html = open(attack_site_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #category変数の値に応じて 各カテゴリページのurlを返すメソッド 引数はvipfendiクラスのクラス変数が入る
    def coltorti_return_category_page_url(attack_site_url, search_category)
        home_doc = coltorti_make_doc(attack_site_url)
        if search_category == "服" then
            #服ならliタグの data-label="Abbigliamento" のhrefを取得
            coltorti_clothing_url = home_doc.css('li[data-label="Abbigliamento"]').css('a').attribute("href").value
            return coltorti_clothing_url
        elsif search_category == "靴" then
            coltorti_shoes_url = home_doc.css('li[data-label="Calzature"]').css('a').attribute("href").value
            return coltorti_shoes_url
        elsif search_category == "バッグ" then
            coltorti_bag_url = home_doc.css('li[data-label="Borse"]').css('a').attribute("href").value
            return coltorti_bag_url
        else
            coltorti_accessori_url = home_doc.css('li[data-label="Accessori"]').css('a').attribute("href").value
            return coltorti_accessori_url
        end
    end

    #クロールするメソッド
    def coltorti_crawl(attack_site_url, search_price, search_category)
        #価格が微妙に低いケースがあるため、1ユーロ安い変数lower_serch_priceを作成する 一度数字にして1を引く その後文字列に戻す
        lower_search_price = search_price.to_i - 1
        lower_search_price = lower_search_price.to_s
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
            if 4 <= lower_search_price.length then
                lower_search_price = lower_search_price.insert(1, ".")
            end
        end
        puts search_price
        puts lower_search_price
        
        #カテゴリーに応じたページURLを取得
        category_page_url = coltorti_return_category_page_url(attack_site_url, search_category)
        #クロール開始
        doc = coltorti_make_doc(category_page_url)
        doc.css('.product-item').each do |node|
            #商品価格を取得する
            item_price = node.css("span.price").inner_text
            #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
            if item_price.include?(search_price) || item_price.include?(lower_search_price) then
                #商品価格 商品名 画像リンク を取得する
                puts item_price.gsub(" ", "")
                puts node.css(".product-item-name").inner_text.strip
                get_url = node.css(".product-item-name").css('a').attribute("href").value
                puts get_url
            end
        end
    end
end