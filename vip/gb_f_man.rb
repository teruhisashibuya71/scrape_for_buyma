require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#ページ送り機能を追加すること
#nextボタンがjsで描画されている?
#カテゴリボタンはHTMLだが、リンクのhrefの値がおかしい これも多分js
#カテゴリボタンのクリック可能ONOFFは data-disabled = "ture" "false" で切り替えしているもよう
#商品が無いカテゴリーのURLにアクセスした場合はwhileの90の条件に引っかからないため、商品有りませんでしたページを1回クーリングして処理終了 よって問題無し
module GbFarfetchMan

    def gbfarfetch_make_doc(gbfarfetch_categorized_url)
        charset = nil
        html = URI.open(gbfarfetch_categorized_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end


    #category変数の値に応じて 各カテゴリページのurlを返すメソッド farfetchは各カテゴリーごとにIDが決められている
    def gbfarfetch_return_category_page_url(attack_site_url, search_category)
        #home_doc = gbfarfetch_make_doc(attack_site_url)
        if search_category == "服" then
            gbfarfetch_clothing_url = attack_site_url.sub(/scale=282/, 'category=136330')
            return gbfarfetch_clothing_url
        elsif search_category == "靴" then
            gbfarfetch_shoes_url = attack_site_url.sub(/scale=282/, 'category=135968')
            return gbfarfetch_shoes_url
        elsif search_category == "バッグ" then
            gbfarfetch_bag_url = attack_site_url.sub(/scale=282/, 'category=135970')
            return gbfarfetch_bag_url
        else
            gbfarfetch_accessori_url = attack_site_url.sub(/scale=282/, 'category=135972')
            return gbfarfetch_accessori_url
        end
    end

    def gbfarfetch_onetime_crawl(attack_site_url, gbfarfetch_search_price, category, doc)
        doc.css('[data-component="ProductCard"]').each do |node|
            item_price = node.css('span[data-testid="price"]').inner_text
            if item_price.include?(gbfarfetch_search_price) then
                #puts item_price
                #puts node.css('p[itemprop="name"]').inner_text
                get_url = node.css('a').attribute("href").value
                access_url = "https://www.farfetch.com" + get_url
                puts access_url
            end
        end
    end

    def gb_farfetch_crawl(attack_site_url, search_price, category)
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
        gbfarfetch_categorized_url = gbfarfetch_return_category_page_url(attack_site_url, category)
        doc = gbfarfetch_make_doc(gbfarfetch_categorized_url)
        products = doc.css('[data-component="ProductCard"]')
        
        #商品数0なら報告する
        if (products.size == 0)
            puts "auzmendi-Farfetchに該当のカテゴリー商品は現在ありません"
        else
            gbfarfetch_onetime_crawl(gbfarfetch_categorized_url, search_price, category, doc)
            page_number = 1 #次ページurl作成用の変数
            #urlのおおまかな変形をwhileの前に実行
            #53 + 3文字= 56文字 
            gbfarfetch_categorized_url = gbfarfetch_categorized_url.insert(56, "page=#{page_number}&")
            
            while doc.css('[data-component="ProductCard"]').size == 90 do
                page_number += 1
                #56文字+5文字
                gbfarfetch_categorized_url[61] = "#{page_number}"
                doc = gbfarfetch_make_doc(gbfarfetch_categorized_url)
                doc.css('[data-component="ProductCard"]').each do |node|
                    item_price = node.css('span[data-testid="price"]').inner_text
                    if item_price.include?(search_price) then
                        #puts item_price
                        #puts node.css('p[itemprop="name"]').inner_text
                        get_url = node.css('a').attribute("href").value
                        access_url = "https://www.farfetch.com" + get_url
                        puts access_url
                    end
                end
                #docの中身を入れ替える
                doc = gbfarfetch_make_doc(gbfarfetch_categorized_url)
            end
        end
    end
end