require 'rubygems'
require 'nokogiri'
require 'open-uri'


#✓後でページ送り機能を念のため付ける
module Gb

    ##docを作るためのメソッド
    #def gb_make_doc(brand_home_url)
    #    options = Selenium::WebDriver::Chrome::Options.new
    #    options.add_argument('--headless')
    #    driver = Selenium::WebDriver.for :chrome, options: options
    #    driver.navigate.to brand_home_url
    #    wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
    #    wait.until { driver.find_element(:class => "scolumns").displayed? }
    #    return driver
    #end


    #category変数の値に応じてアクセスするurlを変える
    def make_categorized_url(attack_site_url, category)
        if category == "服" then
            gb_clothing_url = attack_site_url + "?macrocategory=ABBIGLIAMENTO"
            return gb_clothing_url
        elsif category == "靴" then
            gb_shoes_url = attack_site_url + "?macrocategory=CALZATURE"
            return gb_shoes_url
        elsif category == "バッグ" then
            gb_bag_url = attack_site_url + "?macrocategory=BORSE"
            #puts gb_bag_url
            return gb_bag_url
        else
            gb_accessori_url = attack_site_url + "?macrocategory=ACCESSORI"
            return gb_accessori_url
        end
    end

    #docを作るためのメソッド
    def gb_make_doc(categorized_url)
        #スクレイピング開始する
        charset = nil
        html = URI.open(categorized_url) do |f|
            charset = f.charset
            f.read
        end
        doc = Nokogiri::HTML.parse(html, nil, charset)
        return doc
    end

    #wiseと一緒 1回だけクロール
    def gb_onetime_crowl(doc, search_price)
        items = doc.css(".item")
        if (items.size == 0)
            puts "商品無し"
        else
            doc.css(".item").each do |product|
                #商品価格を取得する
                item_price = product.css(".price").inner_text
                if item_price.include?(search_price) then
                    #商品価格 商品名 画像リンク を取得する
                    #puts item_price.strip
                    #puts product.css(".description-item").text.strip
                    puts product.css('a').attribute("href").value
                end
            end
        end
    end


    #クロールするメソッド
    def gb_crawl(brand_home_url, search_price, category)
        #価格の文字列調整だけ最初に実行
        if search_price.length >= 4 then
            search_price = search_price.insert(1, ".")
        end

        #商品カテゴリー別のURLを取得
        categorized_url = make_categorized_url(brand_home_url, category)
        doc = gb_make_doc(categorized_url)
        #初回クロール
        gb_onetime_crowl(doc, search_price)

        #pagesの要素があるなら次のページのurlを取得する
        if (!doc.css('.pages').empty?)
            #ネクストボタンが押せるうちはクローリングを繰り返す
            while (!doc.css('.pages-item-next').empty?) do
            #次のページのURLを取得
            next_page_url = doc.css('.pages-item-next').css('a').attribute('href')
            #新しいurlでdocを作成
            doc = gb_make_doc(next_page_url)
            #クローリングする
            gb_onetime_crowl(doc, search_price)
            end
        end

    end
end