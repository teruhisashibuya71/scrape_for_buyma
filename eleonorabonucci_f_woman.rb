require 'rubygems'
require 'open-uri'

#処理は大丈夫なはず
module EleonorabonucciFarfetchWoman

    #1.category変数の値に応じて 各カテゴリページのurlを返すメソッド
    #このメソッドは絶対に変わらない
    def elenora_farfetch_return_category_page_url(attack_site_url, search_category)
        #home_doc = elenora_farfetch_make_doc(attack_site_url)
        if search_category == "服" then
            elenora_farfetch_clothing_url = attack_site_url.sub(/scale=274/, 'category=135967')
            return elenora_farfetch_clothing_url
        elsif search_category == "靴" then
            elenora_farfetch_shoes_url = attack_site_url.sub(/scale=274/, 'category=136301')
            return elenora_farfetch_shoes_url
        elsif search_category == "バッグ" then
            elenora_farfetch_bag_url = attack_site_url.sub(/scale=274/, 'category=135971')
            return elenora_farfetch_bag_url
        else
            elenora_farfetch_accessori_url = attack_site_url.sub(/scale=274/, 'category=135973')
            return elenora_farfetch_accessori_url
        end
    end

    #カテゴリーURLを引数としてdocを作成
    def elenora_farfetch_make_doc(elenora_farfetch_categorized_url)
        charset = nil
        html = URI.open(elenora_farfetch_categorized_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end


    def elenora_farfetch_onetime_crowl(doc, elenora_farfetch_target_price)
        products = doc.css('li[data-testid="productCard"]')
        #商品数0なら報告する
        if (products.size == 0)
            puts "elenoraFarfetchに該当のカテゴリー商品は現在ありません"
        end
        products.each do |product|
            #セール価格を先に取得
            item_price = product.css('span[data-testid="initialPrice"]').inner_text
            #セール価格表示が無いなら通常価格を取得
            if (item_price.empty?) then
                item_price = product.css('span[data-testid="price"]').inner_text
            end
            if item_price.include?(elenora_farfetch_target_price) then
                get_url = product.css('a').attribute("href").value
                access_url = "https://www.farfetch.com" + get_url
                #商品アクセスURL
                puts access_url
            end
        end
    end


    def elenora_farfetch_crowl(attack_site_url, target_price, category)
        #価格が4桁の場合は調整
        if target_price.length >= 4 then
            target_price = target_price.insert(1, ".")
        end

        #カテゴリーURLを取得
        elenora_farfetch_categorized_url = elenora_farfetch_return_category_page_url(attack_site_url, category)
        #docを作成
        doc = elenora_farfetch_make_doc(elenora_farfetch_categorized_url)
        
        #初回クロール
        elenora_farfetch_onetime_crowl(doc, target_price)

        #複数ページがある時の処理準備
        page_number = 1 #次ページurl作成用の変数
        #urlのおおまかな変形をwhileの前に実行 各サイトで調整が必要 items.aspx? の後ろに URLの調整が入る
        #https://www.farfetch.com/it/shopping/women/ までで43桁 /items.aspx? 追加で55桁 +ショップ名の名前桁
        #insert以下の数字をショップ名に応じて変えること
        #基本は55文字スタート　elenoraは7文字 55+7=62
        elenora_farfetch_categorized_url = elenora_farfetch_categorized_url.insert(62, "page=#{page_number}&")
        while doc.css('li[data-testid="productCard"]').size == 90 do
            #次ページのURLはpage=2なので+1しとく
            page_number += 1
            
            #基本開始位置は60文字 60+ショップ名の文字数 60+7=67
            elenora_farfetch_categorized_url[65] = "#{page_number}"
            
            #次のページのURLを元にdocを再度作成→変数に代入
            doc = elenora_farfetch_make_doc(elenora_farfetch_categorized_url)
            #2ページ目をクロール
            elenora_farfetch_onetime_crowl(doc, elenora_farfetch_target_price)
        end
    end
end
