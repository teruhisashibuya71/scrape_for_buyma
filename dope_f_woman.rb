require 'rubygems'
require 'open-uri'

=begin
1.○○_farfetchを置換
2.○○_farfetch_return_category_page_urlメソッド scale=272の数値とカテゴリの数値を確認
3.65行目のURL置換の桁数を変更
4.68行目のページ数の数値を変更する
=end

module DoepFarfetchWoman

    def dope_farfetch_make_doc(dope_farfetch_categorized_url)
        charset = nil
        html = open(dope_farfetch_categorized_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end


    #category変数の値に応じて 各カテゴリページのurlを返すメソッド farfetchは各カテゴリーごとにIDが決められている
    def dope_farfetch_return_category_page_url(attack_site_url, search_category)
        if search_category == "服" then
            dope_farfetch_clothing_url = attack_site_url.sub(/scale=274/, 'category=135967')
            return dope_farfetch_clothing_url
        elsif search_category == "靴" then
            dope_farfetch_shoes_url = attack_site_url.sub(/scale=274/, 'category=136301')
            return dope_farfetch_shoes_url
        elsif search_category == "バッグ" then
            dope_farfetch_bag_url = attack_site_url.sub(/scale=274/, 'category=135971')
            return dope_farfetch_bag_url
        else
            dope_farfetch_accessori_url = attack_site_url.sub(/scale=274/, 'category=135973')
            return dope_farfetch_accessori_url
        end
    end


    def dope_farfetch_onetime_crawl(attack_site_url, dope_farfetch_target_price, category, doc)
        doc.css('[data-component="ProductCard"]').each do |node|
            item_price = node.css('span[data-testid="price"]').inner_text
            if item_price.include?(dope_farfetch_target_price) then
                puts item_price
                puts node.css('p[itemprop="name"]').inner_text
                get_url = node.css('a').attribute("href").value
                access_url = "https://www.farfetch.com" + get_url
                puts access_url
            end
        end
    end


    def dope_farfetch_crawl(attack_site_url, target_price, category)
        if target_price.length >= 4 then
            target_price = target_price.insert(1, ".")
        end
        dope_farfetch_categorized_url = dope_farfetch_return_category_page_url(attack_site_url, category)
        doc = dope_farfetch_make_doc(dope_farfetch_categorized_url)
        dope_farfetch_onetime_crawl(dope_farfetch_categorized_url, target_price, category, doc)
        page_number = 1 #次ページurl作成用の変数
        #url調整  urlの「items.aspx?」 の後ろにURLの調整が入る https://www.farfetch.com/it/shopping/women/ までで43桁となる
        dope_farfetch_categorized_url = dope_farfetch_categorized_url.insert(67, "page=#{page_number}&")
        while doc.css('[data-component="ProductCard"]').size == 90 do
            page_number += 1
            dope_farfetch_categorized_url[72] = "#{page_number}" #65行目数字 + 5桁
            doc = dope_farfetch_make_doc(dope_farfetch_categorized_url)
            doc.css('[data-component="ProductCard"]').each do |node|
                item_price = node.css('span[data-testid="price"]').inner_text
                if item_price.include?(target_price) then
                    puts item_price
                    puts node.css('p[itemprop="name"]').inner_text
                    get_url = node.css('a').attribute("href").value
                    access_url = "https://www.farfetch.com" + get_url
                    puts access_url
                end
            end
            #docの中身を入れ替える
            doc = dope_farfetch_make_doc(dope_farfetch_categorized_url)
        end
    end
end
