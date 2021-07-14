require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#ページ送り機能を追加すること
#nextボタンがjsで描画されている?
#カテゴリボタンはHTMLだが、リンクのhrefの値がおかしい これも多分js
#カテゴリボタンのクリック可能ONOFFは data-disabled = "ture" "false" で切り替えしているもよう
#商品が無いカテゴリーのURLにアクセスした場合はwhileの90の条件に引っかからないため、商品有りませんでしたページを1回クーリングして処理終了 よって問題無し
module Leamfarfetch

    def leamfarfetch_make_doc(leamfarfetch_categorized_url)
        charset = nil
        html = open(leamfarfetch_categorized_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end


    #category変数の値に応じて 各カテゴリページのurlを返すメソッド farfetchは各カテゴリーごとにIDが決められている
    def leamfarfetch_return_category_page_url(attack_site_url, search_category)
        #home_doc = leamfarfetch_make_doc(attack_site_url)
        if search_category == "服" then
            leamfarfetch_clothing_url = attack_site_url.sub(/scale=282/, 'category=136330')
            return leamfarfetch_clothing_url
        elsif search_category == "靴" then
            leamfarfetch_shoes_url = attack_site_url.sub(/scale=282/, 'category=135968')
            return leamfarfetch_shoes_url
        elsif search_category == "バッグ" then
            leamfarfetch_bag_url = attack_site_url.sub(/scale=282/, 'category=135970')
            return leamfarfetch_bag_url
        else
            leamfarfetch_accessori_url = attack_site_url.sub(/scale=282/, 'category=135972')
            return leamfarfetch_accessori_url
        end
    end

    def leamfarfetch_onetime_crowl(attack_site_url, leamfarfetch_search_price, category, doc)
        doc.css('li[data-testid="productCard"]').each do |node|
            item_price = node.css('span[data-testid="price"]').inner_text
            if item_price.include?(leamfarfetch_search_price) then
                puts item_price
                puts node.css('p[itemprop="name"]').inner_text
                get_url = node.css('a').attribute("href").value
                access_url = "https://www.farfetch.com" + get_url
                puts access_url
            end
        end
    end

    def leamfarfetch_crowl(attack_site_url, search_price, category)
        if 4 <= search_price.length then
            search_price = search_price.insert(1, ".")
        end
        leamfarfetch_categorized_url = leamfarfetch_return_category_page_url(attack_site_url, category)
        doc = leamfarfetch_make_doc(leamfarfetch_categorized_url)
        leamfarfetch_onetime_crowl(leamfarfetch_categorized_url, search_price, category, doc)
        page_number = 1 #次ページurl作成用の変数
        #urlのおおまかな変形をwhileの前に実行
        leamfarfetch_categorized_url = leamfarfetch_categorized_url.insert(56, "page=#{page_number}&")
        while doc.css('li[data-testid="productCard"]').size == 90 do
            page_number += 1
            leamfarfetch_categorized_url[61] = "#{page_number}"
            puts leamfarfetch_categorized_url
            doc = leamfarfetch_make_doc(leamfarfetch_categorized_url)
            doc.css('li[data-testid="productCard"]').each do |node|
                item_price = node.css('span[data-testid="price"]').inner_text
                if item_price.include?(search_price) then
                    puts item_price
                    puts node.css('p[itemprop="name"]').inner_text
                    get_url = node.css('a').attribute("href").value
                    access_url = "https://www.farfetch.com" + get_url
                    puts access_url
                end
            end
            #docの中身を入れ替える
            doc = leamfarfetch_make_doc(leamfarfetch_categorized_url)
        end
    end
end
