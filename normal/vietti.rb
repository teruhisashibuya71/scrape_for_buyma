require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

#サイトの再アップデート後に改修済み 2023/04/30
#セール価格の時の処理がわからないので後日確認する
#nokogiriに戻した
module Vietti

    #docを作るためのメソッド
    def vietti_make_doc(brand_home_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(brand_home_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    def vietti_onetime_crawl(doc, search_price)
        products = doc.css('.grid__item')
        products.each do |product|
            item_price = product.css('.price-item--regular').inner_text
            if (item_price.include?(search_price)) then
                #puts item_price 
                #puts product_name = product.css('h5').inner_text
                puts "https://viettishop.com" + product.css('a').attribute("href").value
            end
        end
    end

    def vietti_crawl(brand_home_url, search_price)

        #4桁以上の場合はドットを付与
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #初回クローリング
        doc = vietti_make_doc(brand_home_url)
        vietti_onetime_crawl(doc, search_price)

        #pagination-wrapperが存在するかどうかで繰り返しを判断
        if (doc.css('.pagination-wrapper').size >= 1) then

            li_tags_element = doc.css('.pagination__list').css('li')
            li_tags_size = li_tags_element.size
            target_li_index = li_tags_size -2
            li_tags_element[target_li_index].attribute('class').value.to_s.include?('next')
            #pagination__list内部の後ろから2つ目のliのクラス設定を確認。 「next」 を含むのであれば処理を繰り返す
            while (li_tags_element[target_li_index].attribute('class').value.to_s.include?('next')) do
                #次のページのリンクURLを取得
                next_page_url = "https://viettishop.com" + li_tags_element[target_li_index].css('a').attribute("href").value

                doc = vietti_make_doc(next_page_url)
                vietti_onetime_crawl(doc, search_price)

                #liに対して同じ処理を繰り返す
                li_tags_element = doc.css('.pagination__list').css('li')
                li_tags_size = li_tags_element.size
                target_li_index = li_tags_size -2
                if (li_tags_element[target_li_index].attribute('class').nil?) then
                    break
                else
                    li_tags_element[target_li_index].attribute('class').value.to_s.include?('next')
                end
            end
        end
    end
end