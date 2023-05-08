require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

# selenium
# 国設定の変更が必要

module GrifoOld

    #nokogiriはエラーなのでメカナイズを使用
    def grifo_make_doc(brand_home_url)
        agent = Mechanize.new
        page = agent.get(brand_home_url)
        doc = Nokogiri::HTML(page.body)   
        return doc
    end

    #gbと一緒 1回だけクロール
    def grifo_onetime_crawl(doc, search_price, duty_free_price)
        products = doc.css('.product-item')
        products.each do |product|
            #商品価格を取得する
            #セール価格あっても取得可能
            product_price = product.css('.price').inner_text
            if (product_price.include?(search_price) || product_price.include?(duty_free_price)) then
                #商品価格
                #puts product_price.strip
                #商品名
                #puts product.css('.product-item-link').text.strip
                #画像リンク
                puts product.css('a').attribute("href").value
            end
        end
    end

    #クロールするメソッド
    def grifo_crawl(brand_home_url, search_price)
        #税込みか免税かわからないのでpriceを2つ用意する
        #免税価格は小数点以下→四捨五入
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.round.to_s

        #価格の文字列調整を実行 両方に対して
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
            if duty_free_price.length >= 4 then
                duty_free_price = search_price.insert(1, ".")
            end
        end
        #doc作成と商品の有無をチェック
        doc = grifo_make_doc(brand_home_url)
        if (doc.css('.product-item').size == 0)
            puts "grifo210には該当ブランドの商品が現在ありません"
        else
            grifo_onetime_crawl(doc, search_price, duty_free_price)
            #ページ送り要素が空っぽでなければ繰り返し処理へ
            unless (doc.css('.pages').empty?) then
                #nextクラスの要素ががからっぽでなければ繰り返しクローリングする
                until (doc.css('.next').empty?) do
                    #次のページのURLを取得
                    next_page_url = doc.css('.next').css('a').attribute('href')
                    #新しいurlでdocを作成
                    doc = grifo_make_doc(next_page_url)
                    #クローリングする
                    grifo_onetime_crawl(doc, search_price, duty_free_price)
                end
            end
        end
    end
end