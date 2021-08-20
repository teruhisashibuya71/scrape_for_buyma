require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#alducadaostaはjs導入必須
#✓在庫の無いカテゴリーがあった場合にurlがnilになるなるので処理を変更する必要あり
module Tessabit

    #docを作るためのメソッド
    def tessabit_make_doc(attack_site_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(attack_site_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #category変数の値に応じて 各カテゴリページのurlを返すメソッド 引数はvipfendiクラスのクラス変数が入る
    def tessabit_return_category_page_url(attack_site_url, search_category)
        home_doc = tessabit_make_doc(attack_site_url)
        if search_category == "服" then
            tessabit_clothing_url = home_doc.css('li[data-text="Abbigliamento"]').css('a').attribute("href").value #服はliタグ class=data-text="Clothing" のhrefを取得
            return tessabit_clothing_url
        elsif search_category == "靴" then
            tessabit_shoes_url = home_doc.css('li[data-text="Scarpe"]').css('a').attribute("href").value
            return tessabit_shoes_url
        else
            #bagsとAccessoriesの両方のURLを取得してクローリングする必要あり...
            tessabit_bags_url = home_doc.css('li[data-text="Borse"]').css('a').attribute("href").value
            tessabit_accessories_url = home_doc.css('li[data-text="Accessori"]').css('a').attribute("href").value
            tessabit_others_url_array = []
            tessabit_others_url_array.push(tessabit_bags_url)
            tessabit_others_url_array.push(tessabit_accessories_url)
            return tessabit_others_url_array
        end
    end


    #クロールするメソッド
    def tessabit_crawl(attack_site_url, search_price, search_category)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ",")
        end
        #カテゴリーに応じたページURLを取得
        category_page_url = tessabit_return_category_page_url(attack_site_url, search_category)
        #カテゴリーに応じたhtml構造を取得 まずはcategory_page_urlが配列かどうかを判断する
        if category_page_url.instance_of?(Array) then
            #配列に対してクロールする
            category_page_url.each do |target_url|
                doc = tessabit_make_doc(target_url)
                doc.css('.product-box').each do |node|
                    #商品価格を取得する  価格が同じなら商品名とリンクURLを取得する
                    item_price = node.css("span.price").inner_text
                    #もし価格が同じなら
                    if item_price.include?(search_price) then
                        #商品価格 商品名 画像リンク を取得する
                        puts item_price.gsub(" ", "")
                        puts node.css(".product-name").inner_text.strip
                        get_url = node.css('a').attribute("href").value #フルurlが取得される
                        puts get_url
                    end
                end
            end
        else
            #通常のクロールを行う
            doc = tessabit_make_doc(category_page_url)
            doc.css('.product-box').each do |node|
                #商品価格を取得する  価格が同じなら商品名とリンクURLを取得する
                item_price = node.css("span.price").inner_text
                #もし価格が同じなら
                if item_price.include?(search_price) then
                    #商品価格 商品名 画像リンク を取得する
                    puts item_price.gsub(" ", "")
                    puts node.css(".product-name").inner_text.strip
                    get_url = node.css('a').attribute("href").value #フルurlが取得される
                    puts get_url
                end
            end
        end
    end
end