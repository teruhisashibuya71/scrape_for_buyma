require 'rubygems'
require 'open-uri'

=begin
1.○○_farfetchを置換
2.○○_farfetch_return_category_page_urlメソッド scale=274の数値とカテゴリの数値を変更
3.65行目のURL置換の桁数を変更
4.68行目のページ数の数値を変更する
=end

#オリジナルサイトは商品価格違いすぎるので不可能かも
module AmrFarfetchWoman

    def amr_farfetch_make_doc(amr_farfetch_categorized_url)
        charset = nil
        html = URI.open(amr_farfetch_categorized_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end


    #category変数の値に応じて 各カテゴリページのurlを返すメソッド farfetchは各カテゴリーごとにIDが決められている
    def amr_farfetch_return_category_page_url(attack_site_url, search_category)
        #home_doc = amr_farfetch_make_doc(attack_site_url)
        if search_category == "服" then
            amr_farfetch_clothing_url = attack_site_url.sub(/scale=274/, 'category=135967')
            return amr_farfetch_clothing_url
        elsif search_category == "靴" then
            amr_farfetch_shoes_url = attack_site_url.sub(/scale=274/, 'category=136301')
            return amr_farfetch_shoes_url
        elsif search_category == "バッグ" then
            amr_farfetch_bag_url = attack_site_url.sub(/scale=274/, 'category=135971')
            return amr_farfetch_bag_url
        else
            amr_farfetch_accessori_url = attack_site_url.sub(/scale=274/, 'category=135973')
            return amr_farfetch_accessori_url
        end
    end


    def amr_farfetch_onetime_crowl(attack_site_url, amr_farfetch_target_price, category, doc)
        products = doc.css('li[data-testid="productCard"]')
        #商品数0なら報告する
        if (products.size == 0)
            puts "AMR-Farfetchに該当のカテゴリー商品は現在ありません"
        end
        products.each do |product|
            #セール価格を先に取得
            item_price = product.css('span[data-testid="initialPrice"]').inner_text
            #セール価格表示が無いなら通常価格を取得
            if (item_price.empty?) then
                item_price = product.css('span[data-testid="price"]').inner_text
            end
            if item_price.include?(blondie_farfetch_target_price) then
                get_url = product.css('a').attribute("href").value
                access_url = "https://www.farfetch.com" + get_url
                #商品アクセスURL
                puts access_url
            end
        end
    end


    def amr_farfetch_crowl(attack_site_url, target_price, category)
        if target_price.length >= 4 then
            target_price = target_price.insert(1, ".")
        end
        amr_farfetch_categorized_url = amr_farfetch_return_category_page_url(attack_site_url, category)
        doc = amr_farfetch_make_doc(amr_farfetch_categorized_url)
        amr_farfetch_onetime_crowl(amr_farfetch_categorized_url, target_price, category, doc)
        page_number = 1 #次ページurl作成用の変数
        #urlのおおまかな変形をwhileの前に実行 各サイトで調整が必要 items.aspx? の後ろに URLの調整が入る
        #https://www.farfetch.com/it/shopping/women/ までで43桁 /items.aspx? 追加で55桁 +ショップ名の名前桁
        amr_farfetch_categorized_url = amr_farfetch_categorized_url.insert(58, "page=#{page_number}&")
        while doc.css('li[data-testid="productCard"]').size == 90 do
            page_number += 1
            amr_farfetch_categorized_url[63] = "#{page_number}"
            doc = amr_farfetch_make_doc(amr_farfetch_categorized_url)
            doc.css('li[data-testid="productCard"]').each do |node|
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
            doc = amr_farfetch_make_doc(amr_farfetch_categorized_url)
        end
    end
end
