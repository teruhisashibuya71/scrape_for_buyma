require 'rubygems'
require 'open-uri'

#服なら 服と アクティブウェア
#アクセなら アクセと ジュエリー をクロールする必要あり
module OffWhiteManFarfetch

    #1.category変数の値に応じて 各カテゴリページのurlを返すメソッド
    #このメソッドは絶対に変わらない
    def off_white_farfetch_return_category_page_url(attack_site_url, search_category)
        if search_category == "服" then
            off_white_farfetch_clothing_url = attack_site_url + "?page=1&view=90&sort=3&category=136330"
            return auzmendi_farfetch_clothing_url
        elsif search_category == "靴" then
            off_white_farfetch_shoes_url = attack_site_url + "?page=1&view=90&sort=3&scale=282&category=135968"
            return auzmendi_farfetch_shoes_url
        elsif search_category == "バッグ" then
            off_white_farfetch_bag_url = attack_site_url + "?page=1&view=90&sort=3&category=135970"
            return auzmendi_farfetch_bag_url
        else
            #アクセサリーの時
            off_white_farfetch_accessori_url = attack_site_url + "?page=1&view=90&sort=3&category=135970"
            return off_white_farfetch_accessori_url
        end
    end

    #カテゴリーURLを引数としてdocを作成
    def off_white_farfetch_make_doc(off_white_farfetch_categorized_url)
        charset = nil
        html = URI.open(off_white_farfetch_categorized_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end


    def off_white_farfetch_onetime_crawl(doc, auzmendi_farfetch_target_price)
        products = doc.css('[data-component="ProductCard"]')
        products.each do |product|
            #セール価格を先に取得
            item_price = product.css('span[data-testid="initialPrice"]').inner_text
            #セール価格表示が無いなら通常価格を取得
            if (item_price.empty?) then
                item_price = product.css('span[data-testid="price"]').inner_text
            end
            if item_price.include?(auzmendi_farfetch_target_price) then
                get_url = product.css('a').attribute("href").value
                access_url = "https://www.farfetch.com" + get_url
                #商品アクセスURL
                puts access_url
            end
        end
    end


    def off_white_farfetch_crawl(attack_site_url, target_price, category)
        #クロール対象の価格が4桁の場合はドット(.)を入れて調整
        if target_price.length >= 4 then
            target_price = target_price.insert(1, ".")
        end

        #カテゴリーURLを取得
        off_white_farfetch_categorized_url = off_white_farfetch_return_category_page_url(attack_site_url, category)
        #docを作成
        doc = off_white_farfetch_make_doc(off_white_farfetch_categorized_url)
        products = doc.css('[data-component="ProductCard"]')
        #商品数0ならターミナルにメッセージを表示
        if (products.size == 0)
            puts "OFF-WHITE-Farfetchに該当のカテゴリー商品は現在ありません"
        else
            #初回クロール
            off_white_farfetch_onetime_crawl(doc, target_price)
            
            #ページが複数ある時の処理
            #商品数が90個あるなら2ページ目があるとみなして繰り返し処理へ そうでなければ1回クロールして終了
            if (doc.css('[data-component="ProductCard"]').size == 90)
                #次ページのページ番号
                page_number = 2
                #URL中のpage=の次の数字を置き換える page=1 → page=2へ
                off_white_farfetch_categorized_url[67] = "#{page_number}"
                #新しいURLでdocを作りなおす
                doc = off_white_farfetch_make_doc(off_white_farfetch_categorized_url)

                #商品数が90であるうちはうちはクローリングを繰り返す
                while doc.css('[data-component="ProductCard"]').size == 90 do
                    #ページ数を+1する
                    page_number += 1
                    #URLを書き換える
                    off_white_farfetch_categorized_url[67] = "#{page_number}"
                    #次のページのURLを元にdocを再度作成→変数に代入
                    doc = off_white_farfetch_make_doc(off_white_farfetch_categorized_url)
                    #2ページ目をクロール
                    off_white_farfetch_onetime_crawl(doc, off_white_farfetch_target_price)
                end
            end
        end
    end
end
