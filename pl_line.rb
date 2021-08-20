require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'


#特記事項
#カテゴリ分けが細かい URL変換機能は実装しない

module Plline

    #nokogiriはエラーなのでメカナイズを使用
    def plline_make_doc(brand_home_url)
        charset = nil
        html = URI.open(brand_home_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #gbと一緒 1回だけクロール
    def plline_onetime_crawl(doc, search_price)
        products = doc.css('.product')
        products.each do |product|
            #商品価格を取得する
            #セール価格あっても取得可能
            product_price = product.css('.price').inner_text
            if (product_price.include?(search_price)) then
                #商品価格
                #puts product_price.strip
                #商品名
                #puts product.css('.margin-bottom-two').text.strip
                #画像リンク
                puts product.css('a').attribute("href").value
            end
        end
    end

    #クロールするメソッド
    def plline_crawl(brand_home_url, search_price)
        #価格4桁でもドットはつかない

        #doc作成と商品の有無をチェック
        doc = plline_make_doc(brand_home_url)
        if (doc.css('.product').size == 0)
            puts "pllineには該当ブランドの商品が現在ありません"
        else
            plline_onetime_crawl(doc, search_price)
            #ページ送り要素が空っぽでなければ繰り返し処理へ
            unless (doc.css('.pagination').empty?) then

                #aタグの数から繰り返し回数を算出 割り算の後に-1
                crawl_times = doc.css('.pagination').css('a').size / 2 - 1
                #url作成用の番号を用意
                crawling_times = 1
                
                #指定回数クローリングする
                crawl_times.times do
                    crawling_times = crawling_times + 1
                    #次のページのURLを取得
                    puts next_page_url = brand_home_url + "&p=#{crawling_times}"
                    #新しいurlでdocを作成
                    doc = plline_make_doc(next_page_url)
                    #クローリングする
                    plline_onetime_crawl(doc, search_price)
                end
            end
        end
    end
end