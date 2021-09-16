require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'



module Ekseption

  #docを作るためのメソッド
  def ekseption_make_doc(brand_home_url)
      #メカナイズ系
      #url = "https://www.ekseption.com/eu_en/designers/moncler?cat=84"
      #url = "https://www.ekseption.com/ot_en/designers/off_white"
      agent = Mechanize.new
      page = agent.get(brand_home_url)
      doc = Nokogiri::HTML(page.body)  
      return doc
  end

    #gbと一緒 1回だけクロール
    def ekseption_onetime_crawl(doc, duty_free_price)
        products = doc.css('.product-item')
        products.each do |product|
            #商品価格を取得する
            product_price = product.css('.price').inner_text
            if (product_price.include?(duty_free_price)) then
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
    def ekseption_crawl(brand_home_url, search_price)
        #22%免税処理 小数点切り捨て 
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.floor.to_s
        
        #価格の文字列調整だけ最初に実行
        if duty_free_price.length >= 4 then
            duty_free_price = duty_free_price.insert(1, ".")
        end

        #doc作成と商品の有無をチェック
        doc = ekseption_make_doc(brand_home_url)
        if (doc.css('.product-item').size == 0)
            puts "ekseptionには該当ブランドの商品が現在ありません"
        else
            #初回クロール
            ekseption_onetime_crawl(doc, duty_free_price)
            #ページ送り要素(pages)があれば繰り返し処理へ
            if (doc.css('.pages').size > 0) then
                #class=nextのボタンが存在する限りクロールする なぜか2つある 
                while (doc.css('.pages').css('.next').size == 2) do
                    #次のページのURLを取得
                    next_page_url = doc.css('.next').css('a').attribute('href')
                    #新しいurlでdocを作成
                    doc = ekseption_make_doc(next_page_url)
                    #クローリングする
                    ekseption_onetime_crawl(doc, duty_free_price)
                end
            end
        end
    end
end