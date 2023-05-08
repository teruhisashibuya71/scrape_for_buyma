require 'rubygems'
require 'open-uri'

#服なら 服と アクティブウェア
#修正アクセなら アクセと ジュエリー をクロールする必要あり
#ブランド毎に作成する必要がある(URLのため)
module FarfetchMan #①ブランド名を先頭に追加

    #1.category変数の値に応じて 各カテゴリページのurlを返すメソッド
    #このメソッドは絶対に変わらない
    def get_categorized_url(attack_site_url, search_category)  #②メソッド名を修正
        if search_category == "服" then
            #farfetch_clothing_url = attack_site_url + "?page=1&view=90&sort=3&category=136330"  #③付け足す文字列を念のため確認する(基本どのブランドも同じだが)
            return categorized_urls = attack_site_url.insert(-11,"clothing-2/") 
        elsif search_category == "靴" then
            return categorized_urls = attack_site_url.insert(-11,"shoes-2/")
        elsif search_category == "バッグ" then
            return categorized_urls = attack_site_url.insert(-11,"bags-purses-2/")
        else
            #クロール対象がアクセサリーの場合は2つのURLをクロールする
            categorized_urls = []
            first_url = attack_site_url
            first_url = first_url.insert(-11,"accessories-all-2/")
            categorized_urls.push(first_url)
            first_url = first_url.gsub("accessories-all-2/", "")
            first_url = first_url.insert(-11,"jewellery-2/")
            categorized_urls.push(first_url)
            return categorized_urls
        end
    end

    #カテゴリーURLを引数としてdocを作成
    def farfetch_make_doc(categorized_urls)
        charset = nil
        html = URI.open(categorized_urls) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end


    def farfetch_onetime_crawl(doc, target_price)
        products = doc.css('[data-component="ProductCard"]')
        products.each do |product|
            #セール価格を先に取得
            item_price = product.css('span[data-testid="initialPrice"]').inner_text 
            #セール価格表示が無いなら通常価格を取得
            if (item_price.empty?) then
                item_price = product.css('span[data-testid="price"]').inner_text
            end
            if item_price.include?(target_price) then
                get_url = product.css('a').attribute("href").value
                access_url = "https://www.farfetch.com" + get_url
                #商品アクセスURL
                puts access_url
            end
        end
    end


    def farfetch_crawl(attack_site_url, target_price, category)
        
        #クロール対象の価格が4桁の場合はドット(.)を入れて調整
        if target_price.length >= 4 then
            target_price = target_price.insert(1, ".")
        end

        #カテゴリーURLを取得
        categorized_urls = get_categorized_url(attack_site_url, category)
        
        #カテゴリがアクセかどうかで分岐させる
        if (category == "アクセ") then
            #クロールURLが2つの場合はeachを追加
            categorized_url.each do |categorized_urls|
                #通常処理 docを作成
                doc = farfetch_make_doc(categorized_url)
                products = doc.css('[data-component="ProductCard"]')

                #商品数0ならターミナルにメッセージを表示
                if (products.size == 0)
                    puts " Farfetchに該当のカテゴリー商品は現在ありません" #④ブランド名修正
                else
                    #初回クロール
                    farfetch_onetime_crawl(doc, target_price)
                    
                    #ページが複数ある時の処理
                    #商品数が90個あるなら繰り返し処理へ そうでなければ終了
                    if (doc.css('[data-component="ProductCard"]').size == 90)  
                        
                        #次ページのページ番号
                        page_number = 2
                        #URL中のpage=の次の数字を置き換える page=1 → page=2へ
                        categorized_url[69] = "#{page_number}"  #⑤URLの書き換え ブランドにより桁数がことなるので書き換え JIL-SANDER(10文字)で69番目
                        #puts off_white_farfetch_categorized_url
                        #新しいURLでdocを作りなおす
                        doc = farfetch_make_doc(categorized_url)

                        #商品数が90であるうちはうちはクローリングを繰り返す
                        while doc.css('[data-component="ProductCard"]').size == 90 do
                            #ページ数を+1する
                            page_number += 1
                            #URLを書き換える
                            categorized_url[69] = "#{page_number}" #⑥URLの書き換え ブランドにより桁数がことなるので書き換え JIL-SANDER(10文字)で69番目
                            #次のページのURLを元にdocを再度作成→変数に代入
                            doc = farfetch_make_doc(categorized_url)
                            #2ページ目をクロール
                            farfetch_onetime_crawl(doc, target_price)
                        end
                    end
                end
            end
        else
            #通常処理 docを作成
            doc = farfetch_make_doc(categorized_urls)
            products = doc.css('[data-component="ProductCard"]')
            
            #商品数0ならターミナルにメッセージを表示
            if (products.size == 0)
                puts " Farfetchに該当のカテゴリー商品は現在ありません" #④ブランド名修正
            else
                #初回クロール
                farfetch_onetime_crawl(doc, target_price)
                
                #ページが複数ある時の処理
                #商品数が90個あるなら繰り返し処理へ そうでなければ終了
                if (doc.css('[data-component="ProductCard"]').size == 90)  
                    
                    #次ページのページ番号
                    page_number = 2
                    #URL中のpage=の次の数字を置き換える page=1 → page=2へ
                    categorized_urls[69] = "#{page_number}"  #⑤URLの書き換え ブランドにより桁数がことなるので書き換え JIL-SANDER(10文字)で69番目
                    #puts off_white_farfetch_categorized_url
                    #新しいURLでdocを作りなおす
                    doc = farfetch_make_doc(categorized_urls)
    
                    #商品数が90であるうちはうちはクローリングを繰り返す
                    while doc.css('[data-component="ProductCard"]').size == 90 do
                        #ページ数を+1する
                        page_number += 1
                        #URLを書き換える
                        categorized_urls[69] = "#{page_number}" #⑥URLの書き換え ブランドにより桁数がことなるので書き換え JIL-SANDER(10文字)で69番目
                        #次のページのURLを元にdocを再度作成→変数に代入
                        doc = farfetch_make_doc(categorized_urls)
                        #2ページ目をクロール
                        farfetch_onetime_crawl(doc, target_price)
                    end
                end
            end
        end
    end
end
