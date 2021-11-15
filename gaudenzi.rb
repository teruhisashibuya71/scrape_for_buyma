#✔ページ送り機能
module Gaudenzi

    #docを作るためのメソッド
    def gaudenzi_make_doc(attack_site_url)
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
    def gaudenzi_return_category_page_url(attack_site_url, search_category)
        doc = gaudenzi_make_doc(attack_site_url)
        if search_category == "服" then
            #服ならliタグの data-label="Abbigliamento" のhrefを取得
            gaudenzi_clothing_url = attack_site_url + "/clothing"
            return gaudenzi_clothing_url
        elsif search_category == "靴" then
            gaudenzi_shoes_url = attack_site_url + "/shoes"
            return gaudenzi_shoes_url
        elsif search_category == "バッグ" then
            gaudenzi_bag_url = attack_site_url + "/bags"
            return gaudenzi_bag_url
        else
            gaudenzi_accessori_url = attack_site_url + "/shoes"
            return gaudenzi_accessori_url
        end
    end

    def gaudenzi_onetime_crawl(attack_site_url, search_price, doc)
        if (doc.css(".product").size == 0) then
            puts "gaudenziに対象のカテゴリーの商品はありません"
        else
            doc.css(".product").each do |node|
                #商品価格を取得する
                item_price = node.css(".price").inner_text
                #もし価格がsearch_priceあるいはlower_search_priceと同じなら商品名とリンクURLを取得する
                if item_price.include?(search_price) then
                    #商品価格 商品名 画像リンク を取得する
                    #puts item_price
                    #puts node.css(".name").inner_text
                    puts product_url = node.css(".photo").css('a').attribute("href").value
                end
            end
        end
    end

    #クロールするメソッド
    def gaudenzi_crawl(attack_site_url, search_price, search_category)
        search_price = search_price
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
        #カテゴリーに応じたページURLを取得
        category_page_url = gaudenzi_return_category_page_url(attack_site_url, search_category)
        #クロール開始
        doc = gaudenzi_make_doc(category_page_url)
        gaudenzi_onetime_crawl(category_page_url, search_price, doc)
        #ページ送り機能 クラスpagerのaタグの数が1つ かつ 最初のaタグのclass名がprevである時までクローリングを実施
        if !doc.css('.next').inner_text.empty? then
            until doc.css('.pager').css('a').size == 1 && doc.css('.pager').css('a')[0].attr('class').to_s == "prev" do
                #次のページのURLを取得
                next_page_url = doc.css('.next').css('a').attribute("href")
                attack_site_url = next_page_url
                #docを詰め替える
                doc = gaudenzi_make_doc(attack_site_url)
                #クローリングする
                gaudenzi_onetime_crawl(attack_site_url, search_price, doc)
            end
        end
    end
end