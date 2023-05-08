require 'nokogiri'
require 'open-uri'


#ruby z_noko_test.rb
#①doc取得
#----------------------------------------------------------------
url = "https://www.pozzilei.it/en/givenchy"
#url = "https://www.wrongweather.net/jp/shop/brand/oamc?page=3"
search_price = "590"

charset = nil
html = URI.open(url) do |f|
    charset = f.charset
    f.read
end
doc = Nokogiri::HTML.parse(html, nil, charset)
#----------------------------------------------------------------

#②商品取得確認
#---------------------------------------------------
products = doc.css('.product-item')
puts products
#puts products = doc.css('.mt-10 .gap-y-12 .items-center').size #商品商品の取得

# puts pagenate = doc.css('.mt-10 .justify-between .justify-end').size #結果は1
# puts pagenate = doc.css('.mt-10 .justify-between .justify-end').css('button').css('disabled')
# #結果 disabled
# puts pagenate = doc.css('.mt-10 .justify-between .justify-end').css('button').attribute('disabled')

# boo = doc.css('.mt-10 .justify-between .justify-end').css('button').attribute('disabled').to_s == "disabled"
# puts boo
#puts products = doc.css('.mt-10').size
#---------------------------------------------------

#③.クロール1回だけ 簡易動作確認ソース
doc.css('[data-component="ProductCard"]').each do |product|
#doc.css(".product-preview").each do |product|
    #puts "テスト" Price

    #セール価格がある場合など
    if (product.css('[data-component="PriceOriginal"]').size >= 1) then
        puts item_price = product.css('[data-component="PriceOriginal"]').inner_text
    else
        puts item_price = product.css('[data-component="Price"]').inner_text
    end

    #puts item_price = product.css(".price").inner_text.strip
    
    #if item_price.include?(search_price) then
    #    #商品価格 商品名 画像リンク を取得する
    #    puts item_price
    #    puts product.css(".prodotto").inner_text
    #    puts product.css(".cnt").css('a').attribute("href").value
    #    #puts "https://eleonorabonucci.com/" + product_url = node.css(".product-image").css('a').attribute("href").value
    #end
end

#④.pagination要素取得
# puts "paginate要素"
# puts doc.css(".paginazione").css("li").last.inner_text
# if (doc.css(".paginazione").css("li").last.inner_text == "〉") then
#     puts "クロール終了"
# end
#page-listの最後の要素に
#puts str = doc.css(".page-list li").last.css('a').attribute('href')









#2.繰り返し処理の動作確認ソース
#価格の文字列調整だけ最初に実行
# if search_price.length >= 4 then
#     search_price = search_price.insert(1, ",")
# end

#クロール開始
# doc = gaudenzi_make_doc(attack_site_url)
# eleonorabonucci_one_time_crawl(doc, search_price)
# #>>が画面上に表示されているうちはクローリングを繰り返す
# if (!doc.css("#MainContent_hlLastPage").empty?) then
#         #次のページのURLを取得
#         #next_page_url = doc.css('#MainContent_hlLastPage').css('a').attribute("href")
#         next_page_url = doc.css('#MainContent_hlLastPage').attribute("href")
#         attack_site_url = next_page_url
#         #docを詰め替える
#         doc = eleonorabonucci_make_doc(attack_site_url)
#         #クローリングする
#         eleonorabonucci_onetime_crawl(attack_site_url, search_price, doc)
#     end
# end


#puts pagewise = doc.css(".next")
#puts pagewise.empty?

##shipping to JAPANと120品表示に切り替えを行うメソッド
#def prepare_crawl(brand_home_url)
#    options = Selenium::WebDriver::Chrome::Options.new
#    options.add_argument('--headless')
#    driver = Selenium::WebDriver.for :chrome, options: options
#    driver.navigate.to brand_home_url
#    wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
#    wait.until { driver.find_element(:class => "scolumns").displayed? }
#    #puts driver.page_source.class #String型
#    #puts driver.class #String型
#    #puts driver.find_elements(:class => "product-item")
#    products = driver.find_elements(:class => "product-item")
#    products.each do |product|
#        item_price = product.find_element(:class => "price") #inner_textは使えない
#        puts item_price.text #中身の表示は.textメソッド
#        puts product.find_element(:tag_name, 'a').attribute("href")  #(:tag_name, 'タグ名').attribute("href")
#    end
#end



#①nokogiriの基本構文 リファレンス
# #最初のaタグを取得する構文を考えるところから
# #puts doc.css('.categories').css('a')[0].attribute("href")
# #puts !doc.css('.next').inner_text.empty?
# #puts doc.css('.pager').css('a').value
# #puts doc.css('.pager').css('a').attr('class').to_s == "next"
# #puts doc.css('.pager').css('a').size
# #puts doc.css('.pager').css('a')[0].attr('class').to_s == "prev"
# puts doc.css('.next').css('a').attribute("href")
#puts doc.css('categories[title="abbigliamento"]')




