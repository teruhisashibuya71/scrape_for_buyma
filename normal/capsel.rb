require 'rubygems'
require 'nokogiri'
require 'open-uri'


#特記事項
#カテゴリ分けが使えないサイト

module Capsel

    #docを作るためのメソッド
    def capsel_make_doc(brand_home_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(brand_home_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #gbと一緒 1回だけクロール
    def capsel_onetime_crawl(doc, duty_free_price, adjust_price)
        products = doc.css('.contfoto')
        if (products.size == 0)
            puts "capselには該当ブランドの商品が現在ありません"
        else
            products.each do |product|
                #商品価格を取得する
                #セール価格あっても取得可能
                product_price = product.css('.prezzo').inner_text
                if (product_price.include?(duty_free_price) || product_price.include?(adjust_price)) then
                    #puts item_price.gsub(" ", "")
                    #puts node.css(".notranslate").inner_text.strip
                    get_url = product.css('a').attribute("href").value
                    puts "https://www.capsulebyeso.com/en/" + get_url
                end
            end
        end
    end


    #クロールするメソッド
    def capsel_crawl(brand_home_url, search_price)
        #免税価格に調整 切り上げ cell  四捨五入.round 切り捨て.floor 
        #切り上げ.cell
        duty_free_price = search_price.to_i / 1.2
        adjust_price = duty_free_price.ceil + 1
        adjust_price = adjust_price.to_s
        duty_free_price = duty_free_price.ceil.to_s

        #なぜか1円高い価格になることもある
        

        #価格の文字列調整だけ最初に実行 「.」調整
        if duty_free_price.length >= 4 then
            duty_free_price = duty_free_price.insert(1, ".")
            adjust_price = adjust_price.insert(1, ".")
        end



        doc = capsel_make_doc(brand_home_url)
        #初回クロール
        capsel_onetime_crawl(doc, duty_free_price, adjust_price)

        #URL操作用のの文字と数字の変数を用意
        page_adjust_url = "?page="
        page_number_url = 1

        #page-list要素が空っぽでなければ繰り返し処理へ入る
        if (!doc.css('.bloccopagine').empty?)
            
            #pagineクラスの最後の要素のテキストがLASTなら繰り返す while → trueなら処理
            while (doc.css('.bloccopagine').css('.pagine').last.inner_text.include?('LAST')) do
                
                page_number_url += 1
                #次のページのURLを取得
                next_page_url = brand_home_url + page_adjust_url + page_number_url.to_s
                
                #新しいurlでdocを作成
                doc = capsel_make_doc(next_page_url)

                #クローリングする
                capsel_onetime_crawl(doc, duty_free_price, adjust_price)

            end
        end
    end
end