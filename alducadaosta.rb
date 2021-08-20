require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#alducadaostaはjs導入必須
module Alducadaosta

    #category変数の値に応じて 各カテゴリページのurlを返すメソッド 引数はvipfendiクラスのクラス変数が入る
    def alducadaosta_return_category_page_url(attack_site_url, search_category)
        if search_category == "服" then
            return category_page_url = attack_site_url + "/scarpe"
        elsif search_category == "靴" then
            return category_page_url = attack_site_url + "/abbigliamento"
        elsif search_category == "バッグ" then
            return category_page_url = attack_site_url + "/borse"
        else
            return category_page_url = attack_site_url + "/accessori"
        end
    end

    #docを作るためのメソッド
    def alducadaosta_make_doc(categroy_page_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(categroy_page_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #クロールするメソッド
    def alducadaosta_crawl(attack_site_url, search_price, search_category)
        #価格が微妙に低い・高いケースがあるため、1ユーロ高い変数HIGER_serch_priceを作成する 一度数字にして1をたす その後文字列に戻す
        higher_search_price = search_price.to_i + 1
        higher_search_price = higher_search_price.to_s

        lower_search_price = search_price.to_i - 1
        lower_search_price = lower_search_price.to_s
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
            higher_search_price = higher_search_price.insert(1, ".")
            lower_search_price = lower_search_price.insert(1, ".")
        end
        #カテゴリーに応じたページURLを取得
        category_page_url = alducadaosta_return_category_page_url(attack_site_url, search_category)

        #カテゴリーに応じたhtml構造を取得
        doc = alducadaosta_make_doc(category_page_url)
        if (doc.css('.product').size == 0) then
            puts "alducadaostaにこのカテゴリーの商品は現在ありません"
        else
            #クロール開始
            doc.css('.product').each do |node|
                #商品価格を取得する  価格が同じなら商品名とリンクURLを取得する
                item_price = node.css("span.product__price").inner_text
                #もし価格が同じなら
                if item_price.include?(search_price) || item_price.include?(higher_search_price) || item_price.include?(lower_search_price) then
                    #商品価格 商品名 画像リンク を取得する
                    puts item_price
                    puts node.css("span.product__name").inner_text
                    get_url = node.css('a').attribute("href").value
                    access_url = "https://www.alducadaosta.com" + get_url
                    puts access_url
                end
            end
        end
    end
end