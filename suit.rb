require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

module Suit
    @@suit_agent = Mechanize.new

    #1.docを作るためのメソッド
    def suit_make_doc(attack_site_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(attack_site_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return  doc
    end

    #2.Succivoがあるかどうかの判断
    def suit_judge_multipage(doc)
        is_successivo = doc.css('.next').inner_text.strip
        return is_successivo
    end

    #3.純粋に1度クロールするメソッド
    def suit_just_crawl(doc, suit_search_price)
        doc.css('.product-card').each do |node|
            item_price = node.css("span.money").inner_text
            #もし価格が同じなら商品価格 商品名 画像リンク を取得する
            if item_price.include?(suit_search_price) then
                puts item_price
                puts node.css("h3").inner_text
                get_img_url = node.css('a').attribute("href").value
                access_img_url = "https://suitnegozi.com/" + get_img_url
                puts access_img_url
            end
        end
    end

    #4.次のページのurlを変数「url」に再度代入するメソッド
    def suit_get_next_page_url(attack_site_url)
        page = @@suit_agent.get(attack_site_url)
        relative_link_url = @@suit_agent.page.search('//div[@class="next"]/a/@href').text
        next_page_url = "https://suitnegozi.com" + relative_link_url
        return next_page_url
    end

    #5.新しいhtml構造のnew_docをdocに再度代入するするメソッド
    def suit_prepare_new_doc(next_page_url)
        #次のページのurlを
        charset = nil
        html = URI.open(next_page_url) do |f|
            charset = f.charset
            f.read
        end
        new_doc = Nokogiri::HTML.parse(html, nil, charset)
        return new_doc
    end

    #6.ページ送りできるクロールメソッド メソッド1〜5を内包
    def suit_crawl(attack_site_url, search_price)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end
        doc = suit_make_doc(attack_site_url)
        is_successivo = suit_judge_multipage(doc)
        if is_successivo.include?("Successivo") then
            #succevoが押せなくなるまで → class名に disableを含むかどうか
            until doc.css('.disabled').inner_text.strip ==  "Successivo" do
                #クローリングメソッド呼び出す
                suit_just_crawl(doc, search_price)
                #Mechanizeを利用して次のページのurlを取得して同じ変数を上書き
                attack_site_url = suit_get_next_page_url(attack_site_url)
                #新しいurlのhtml構造をdocに代入する
                doc = suit_prepare_new_doc(attack_site_url)
            end
            #while抜けた後(最終ページにたどり着いた時は)1回クローリングして処理終了
            suit_just_crawl(doc, search_price)
        elsif
            # succsivo無し → 1回クローリングして終了
            suit_just_crawl(doc, search_price)
        end
    end
end