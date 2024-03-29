
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#nokogiri
#サイト改修に対応済み 20223/01/07
#免税価格/1ユーロ価格上下対応

module Russocapri

    #docを作るためのメソッド
    def russo_make_doc(attack_site_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(attack_site_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #最初のクローリング
    def russo_onetime_crawl(attack_site_url, low_search_price, lower_search_price, search_price, higher_search_price, high_search_price, doc)
        doc.css('.item').each do |product|
            #商品価格を取得する  価格が同じなら商品名とリンクURLを取得する
            product_price = product.css("h6").inner_text.delete("€").strip
            #もし価格が同じなら

            if (product_price.include?(low_search_price) || product_price.include?(lower_search_price) || product_price.include?(search_price) || product_price.include?(higher_search_price) || product_price.include?(high_search_price)) then
                #商品価格
                #puts item_price.strip
                #商品名
                #puts product.css("p").inner_text
                #リンクurl
                puts product.css('a').attribute("href").value
            end
        end
    end

    #li要素の最後を取得するメソッド
    def make_last_li_elemnt(doc)
        li_elements = doc.css("#paginazione").css("li")
        li_size = li_elements.size
        last_li_number = li_size - 1
        last_li_element = li_elements[last_li_number]
        return last_li_element
    end

    #クロールするメソッド
    def russo_crawl(attack_site_url, search_price)

        #免税処理
        search_price = search_price.to_i / 1.22
        search_price = search_price.floor

        #商品価格調整
        #価格が微妙に低い・高いケースがあるため、1ユーロ安い変数lower_serch_priceを作成する 一度数字にして1を引く その後文字列に戻す
        lower_search_price = search_price.to_i - 1
        lower_search_price = lower_search_price.to_s

        low_search_price = search_price.to_i - 2
        low_search_price = low_search_price.to_s

        higher_search_price = search_price.to_i + 1
        higher_search_price = higher_search_price.to_s

        high_search_price = search_price.to_i + 2
        high_search_price = high_search_price.to_s

        #最後に文字列に戻す
        search_price = search_price.to_s

        doc = russo_make_doc(attack_site_url)
        russo_onetime_crawl(attack_site_url, low_search_price, lower_search_price, search_price, higher_search_price, high_search_price, doc)
        
        #liの最後の要素を取得
        last_li_element = make_last_li_elemnt(doc)
        
        #最後のliにec-_pagerがあるなら繰り返しクロールする処理に移行 1ページだけなら処理終了
        if (last_li_element.to_s.include?("ec_pager")) then

            #ec_pagerの表記が無くなるまでクロールする
            while (last_li_element.to_s.include?("ec_pager")) do
                #次のページのURLを取得
                nextpage_urls = doc.css('.ec_pager')
                array_number = nextpage_urls.length
                nextpage_url_element = array_number -1
                attack_site_url = nextpage_urls[nextpage_url_element].attribute('href')
                
                #docを詰め替える
                doc = russo_make_doc(attack_site_url)
                #クローリングする
                russo_onetime_crawl(attack_site_url, search_price, doc)
                #次のページにおける最後のli要素を再度取得する
                last_li_element = make_last_li_elemnt(doc)
            end

            #最後のページを1回クロールして終了
            russo_onetime_crawl(attack_site_url, low_search_price, lower_search_price, search_price, higher_search_price, high_search_price, doc)
        end
        
    end
end