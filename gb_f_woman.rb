require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'


module GbFarfetchWoman

    def gbfarfetch_make_doc(gbfarfetch_categorized_url)
        charset = nil
        html = open(gbfarfetch_categorized_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end


    #category変数の値に応じて 各カテゴリページのurlを返すメソッド farfetchは各カテゴリーごとにIDが決められている レディースはscale=274
    def gbfarfetch_return_category_page_url(attack_site_url, search_category)
        if search_category == "服" then
            gbfarfetch_clothing_url = attack_site_url.sub(/scale=274/, 'category=135967')
            return gbfarfetch_clothing_url
        elsif search_category == "靴" then
            gbfarfetch_shoes_url = attack_site_url.sub(/scale=274/, 'category=136301')
            return gbfarfetch_shoes_url
        elsif search_category == "バッグ" then
            gbfarfetch_bag_url = attack_site_url.sub(/scale=274/, 'category=135971')
            return gbfarfetch_bag_url
        else
            gbfarfetch_accessori_url = attack_site_url.sub(/scale=274/, 'category=135973')
            return gbfarfetch_accessori_url
        end
    end

    def gbfarfetch_onetime_crawl(attack_site_url, gbfarfetch_search_price, category, doc)
        doc.css('li[data-testid="productCard"]').each do |node|
            item_price = node.css('span[data-testid="price"]').inner_text
            if item_price.include?(gbfarfetch_search_price) then
                puts item_price
                puts node.css('p[itemprop="name"]').inner_text
                get_url = node.css('a').attribute("href").value
                access_url = "https://www.farfetch.com" + get_url
                puts access_url
            end
        end
    end

    def gbfarfetch_crawl(attack_site_url, search_price, category)
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
        gbfarfetch_categorized_url = gbfarfetch_return_category_page_url(attack_site_url, category)
        doc = gbfarfetch_make_doc(gbfarfetch_categorized_url)
        gbfarfetch_onetime_crawl(gbfarfetch_categorized_url, search_price, category, doc)
        page_number = 1 #次ページurl作成用の変数
        #urlのおおまかな変形をwhileの前に実行 メンズとレディースで桁数変わるので注意
        gbfarfetch_categorized_url = gbfarfetch_categorized_url.insert(58, "page=#{page_number}&")
        while doc.css('li[data-testid="productCard"]').size == 90 do
            page_number += 1
            gbfarfetch_categorized_url[63] = "#{page_number}"
            doc = gbfarfetch_make_doc(gbfarfetch_categorized_url)
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
            doc = gbfarfetch_make_doc(gbfarfetch_categorized_url)
        end
    end
end