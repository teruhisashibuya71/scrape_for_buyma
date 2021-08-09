require 'rubygems'
require 'open-uri'


attack_site_url = "https://www.farfetch.com/it/shopping/women/bruna-rosso/items.aspx?view=90&scale=274&designer=4224"

# charset = nil
# html = URI.open(attack_site_url) do |f|
#     charset = f.charset
#     f.read
# end
# doc = Nokogiri::HTML.parse(html, nil, charset)


search_price = ""
search_category = ""

        #ここはどんなページでも全て同じ
        if search_category == "服" then
            attack_site_url = attack_site_url.sub(/scale=274/, 'category=135967')
        elsif search_category == "靴" then
            attack_site_url = attack_site_url.sub(/scale=274/, 'category=136301')
        elsif search_category == "バッグ" then
            attack_site_url = attack_site_url.sub(/scale=274/, 'category=135971')
        else
            attack_site_url = attack_site_url.sub(/scale=274/, 'category=135973')
        end

        #def bruna_farfetch_crowl(attack_site_url, target_price, category)
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #html要素を取得
        charset = nil
        html = URI.open(attack_site_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)


        page_number = 1 #次ページurl作成用の変数
        #urlのおおまかな変形をwhileの前に実行 各サイトで調整が必要 items.aspx? の後ろに URLの調整が入る
        #https://www.farfetch.com/it/shopping/women/ までで43桁 /items.aspx? 追加で55桁 +ショップ名の名前桁
        attack_site_url = attack_site_url.insert(54, "page=#{page_number}&")
        while doc.css('li[data-testid="productCard"]').size == 90 do
            page_number += 1
            attack_site_url[59] = "#{page_number}"
            doc = bruna_farfetch_make_doc(bruna_farfetch_categorized_url)
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
            doc = bruna_farfetch_make_doc(bruna_farfetch_categorized_url)
        end
    #end

        #最後のページを1回Chloeリングして終了
        doc.css('li[data-testid="productCard"]').each do |node|
            item_price = node.css('span[data-testid="price"]').inner_text
            if item_price.include?(bruna_farfetch_target_price) then
                puts item_price
                puts node.css('p[itemprop="name"]').inner_text
                get_url = node.css('a').attribute("href").value
                access_url = "https://www.farfetch.com" + get_url
                puts access_url
            end
        end
    


