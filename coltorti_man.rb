require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#✔ページ送り機能
module ColtortiMan

    #docを作るためのメソッド
    def coltorti_make_doc(attack_site_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(attack_site_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    def coltorti_return_category_page_url(attack_site_url, search_category)
        3.times {
            attack_site_url = attack_site_url.chop    
        }
        if search_category == "服" then
            attack_site_url = attack_site_url + "157"
            return attack_site_url
        elsif search_category == "靴" then
            attack_site_url = attack_site_url + "154"
            return attack_site_url
        elsif search_category == "バッグ" then
            attack_site_url = attack_site_url + "177"
            return attack_site_url
        else
            attack_site_url = attack_site_url + "152"
            return attack_site_url
        end
    end

    def coltorti_onetime_crawl(doc, search_price, lower_search_price)
        doc.css('.product-item').each do |product|    
            #商品価格を取得する
            item_price = product.css("span.price").inner_text
            #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
            if item_price.include?(search_price) || item_price.include?(lower_search_price) then
                #商品価格 商品名 画像リンク を取得する
                #puts item_price.gsub(" ", "")
                #puts product.css(".product-item-name").inner_text.strip
                puts get_url = product.css(".product-item-name").css('a').attribute("href").value
            end
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
        
        #カテゴリーに応じたページURLを取得
        category_page_url = coltorti_return_category_page_url(attack_site_url, search_category)
        doc = coltorti_make_doc(category_page_url)
        #商品無いなら終了
        if (doc.css('.product-item').size == 0) then
            puts "coltortiに該当カテゴリの商品無し"
        else
            #初回クロール
            coltorti_onetime_crawl(doc, search_price, lower_search_price)
            #繰り返し処理
            doc.css('.pages').size
            if (doc.css('.pages').size != 0 ) then
                #次の矢印があるうちは繰り返す
                while (doc.css('.pages-item-next') != 0) do
                    #次のページのURL取得
                    next_page_url = doc.css('.pages-item-next').css('a').attribute("href")
                    attack_site_url = next_page_url      
                    #docの詰め替え
                    doc = coltorti_make_doc(attack_site_url)
                    #再度クロール
                    coltorti_onetime_crawl(doc, search_price, lower_search_price)
                    if doc.css('.pages-item-next').size == 0
                        break
                    end
                end
            end
        end
    end
end