require 'rubygems'
require 'nokogiri'
require 'open-uri'


#docを作るためのメソッド
#スクレイピング開始する
charset = nil
#html = URI.open("https://www.antonia.it/it/brands/moncler") do |f|   
html = URI.open("https://www.tessabit.com/en_it/woman/designers/moncler.html?page=1") do |f|

charset = f.charset
    f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
puts doc.css('.izHQXc').size

#puts doc.css('.pagination').css('.selected').inner_text
#0.使用確認
#puts doc

#1.取得商品数の確認
#puts doc.css('.productContent').size

#2.対象価格
#search_price = "844"

#3.免税処理 価格は小数点表示のため、小数点以下は切り捨ててOK
#切り上げ .ceil
#切り捨て .floor
#四捨五入 .round
#duty_free_price = search_price.to_i / 1.22
#duty_free_price = duty_free_price.floor.to_s


#4商品の桁数調整
# if search_price.length >= 4 then
#     search_price = search_price.insert(1, ".")
# end

#4商品の桁数調整(免税version)
# if duty_free_price.length >= 4 then
#     duty_free_price = duty_free_price.insert(1, ".")
# end




#商品product-item-info
#名前product-item-name
#価格price-box
#リンク

# puts doc.css('.product-item').size
# #1.各要素の取得確認
# products = doc.css('.product-item')
#     products.each do |product|
#     #商品価格を取得する
#     puts product_price = product.css('.price').inner_text
#     #puts product.css(".price-box").text.strip
#     #if product_price.include?(search_price) then
#         #商品価格
#         puts product_price.strip
#         #商品名
#         puts product.css(".h5").inner_text.strip
#         #画像リンク
#         puts product.css('a').attribute("href").value
#         #puts "https://www.dafneshop.it" + product.css('a').attribute("href").value
#     #end
# end


#1.各要素の取得確認(免税version)
# products = doc.css('.product-miniature')
# products.each do |product|
#     #商品価格を取得する
#     product_price = product.css('.product-price-and-shipping').inner_text
#     #puts product.css(".product-title").text.strip
#     if product_price.include?(duty_free_price) then
#         #商品価格
#         puts product_price.strip
#         #商品名
#         puts product.css(".product-title").inner_text.strip
#         #画像リンク
#         puts product.css('a').attribute("href").value
#         #puts "https://www.dafneshop.it" + product.css('a').attribute("href").value
#     end
# end




# products = doc.css('.product-item')
#     puts products[0].to_s
#     puts products[0].css('.regular-price').inner_text
#     puts products[0].css(".product-name").inner_text.strip
#     puts products[0].css('a').attribute("href").value




#3.繰り返し処理選定作業
#puts doc.css('.pagination').empty?
#puts doc.css('.next').empty?
#puts doc.css('.nex').css('a').empty?
#sizeメソッドの戻り値は integer
#puts doc.css('.pagination').css('a').size
#puts crawl_timess = doc.css('.pagination').css('a').size / 2 - 1
#puts crawl_timess = crawl_timess / 2 - 1
#puts doc.css('#pagination').css('li').size

#.attribute('href')
#


#puts crawled_urls.include?(brand_home_url)



#4
#products = doc.css('.item').css('.price-box')

# products = doc.css('.product-small')
        
# products.each do |product|
# puts product.css('.price').inner_text
# puts product.css('.product-title').inner_text
# puts product.css('a').attribute("href").value
# end

#価格の文字列調整だけ最初に実行
# if search_price.length >= 4 then
#     search_price = search_price.insert(1, ".")
# end

# if (products.size == 0)
#     puts "actuel-Bには該当ブランドの商品が現在ありません"
# else
#     products.each do |product|
#     #商品価格を取得する
#     #puts product.css('.price').inner_text
#     #puts product.css(".product-title").text.strip
#     product_price = product.css('.price').inner_text
    
#         if (!doc.css('.bottom-pagination').css('a').empty?) then
#             #繰り返し条件の入力
#             while (!doc.css('.next').empty?) do

#                 if product_price.include?(search_price) then
#                     #商品価格
#                     puts product_price.strip
#                     #商品名
#                     puts product.css(".category").text.strip
#                     #画像リンク
#                     #puts product.css('a').attribute("href").value
#                     puts "https://www.lidiashopping.com/" + product.css('a').attribute("href").value
#                 end
#             end
#         end
#     end
# end






#2.ページ送りパーツの有無
#puts doc.css('.page-list').css('li').size

#puts doc.css('.next').empty?


#3.次ページのurl取得
#puts doc.css('.next').css('a').attribute('href')

#4.次のページのURLを取得
#puts next_page_url = doc.css('.next').css('a').attribute('href').nil?


#免税価格を計算
#duty_free_price = search_price.to_i / 1.2
#duty_free_price = duty_free_price.round.to_s


#products = doc.css('.js-product-miniature-wrapper')
            # products.each do |product|
            #     #商品価格を取得する
            #     #セール価格の有無を確認
            #     if (product.css('.regular-price').empty?) then
            #         #セール価格の表記が無いなら定価を比較対象に取得
            #         product_price = product.css('.price').inner_text
            #     else
            #         #セール価格の表記があるならregular_priceを比較対象として取得
            #         product_price = product.css('.regular-price').inner_text
            #     end
            #     if (product_price.include?(search_price)) then
            #         #商品価格 商品名 画像リンク を取得する
            #         #puts product_price.strip
            #         #puts product.css(".description-item").text.strip
            #         puts product.css('a').attribute("href").value
            #     end
            # end





# products = doc.css('.js-product-miniature-wrapper')
#         if (products.size == 0)
#             puts "actuel-Bには該当ブランドの商品が現在ありません"
#         else
#             products.each do |product|
#             #商品価格を取得する
#             puts product.css('.regular-price').inner_text
#             puts product.css(".product-title").text.strip
#             # product_price = product.css('.product-price-and-shipping').inner_text
#             #     if product_price.include?(search_price) then
#             #         #商品価格 商品名 画像リンク を取得する
#             #         #puts product_price.strip
#             #         puts product.css(".product-title").text.strip
#             #         puts product.css('a').attribute("href").value
#             #     end
#             end
#         end




#while (doc.css('.body__text--breadcrumb').css("span").size != 2 && doc.css('.body__text--breadcrumb').css("span")[0].text != "Prev") do

#次のページのURL
#puts doc.css('.pagination--container').css('.tertiary__color').css('a').attribute('href')

#数は2こ  doc.cssまでは 配列形式 attribute使うとStringになっちゃう？のかもしれない
#puts doc.css('.pagination--container').css('.tertiary__color').size
#puts doc.css('.pagination--container').css('.tertiary__color').css('a').size






#urlを獲得
#puts doc.css('.pagination--container').css('.tertiary__color').css('a')[1].attribute('href')


#urls = doc.css('.pagination--container').css('.tertiary__color').css('a')
#puts urls.attribute('href')

#puts urls[1].attribute('href')


#urls = doc.css('.pagination--container').css('.tertiary__color')


#prevnext.each do |object|
#    puts object
#end
#puts doc.at("span").inner_text


#商品の取得
# doc.css(".product__item__link--container").each do |product|
#     #商品価格を取得する
#     item_price = product.css(".primary__color").inner_text
#     if item_price.include?(search_price) then
#         #商品価格 商品名 画像リンク を取得する
#         #puts item_price.strip
#         #puts item_price.gsub(" ", "") 
#         #puts product.css(".title").text.strip
#         #puts product.css(".body__text").text.gsub(" ", "")
#         #puts product.css(".body__text").size
#         puts product.css('a').attribute("href").value
#     end
# end


# if doc.css('.pages').empty?
#     puts "空っぽ"
# else
#     puts "次ページあり"
# end
#nextpage_urls =
#puts doc.css('.ec_pager').to_s.include?("htps")
#puts doc 

# doc.css(".item").each do |product|
#     #商品価格を取得する
#     item_price = product.css(".price").inner_text
#     if item_price.include?(wise_search_price) then
#         #商品価格
#         puts item_price.strip
#         #商品絵名
#         #puts product.css(".description-item").text.strip
#         puts product.css("p").inner_text
#         #リンクurl
#         puts product.css('a').attribute("href").value
#     end
# end




#nnext = doc.css(".next")
#nnext = doc.css(".pages").empty?
#puts nnext




#次のページの要素を取得する部分



# pager = doc.css(".ec_pager")
# if (pager.size < 1)
#     puts 1 
# else
#     puts pager[1]
# end



# elements_li = doc.css("#paginazione").css("li")
# li_size = amount_li.size
# last_li_number = li_size - 1
# last_li_element = elements_li[last_li_number]
# #ture!!!でOK
# puts last_li_element.to_s.include?("disabled")



#disableなら奈良クロール終了
#違うならurl入力ｓてクロール継続


#puts innertextlastli.inner_text.include?("disabled")
# if (innertextlastli.text("disabled")?)
#     puts "最終ページです"
# else
#     puts "まだページある"
# end

# if (doc.css("paginazione").empty?)
#     #何もしない
# else  
#     unless doc.css("paginazione").empty? then
#         #次のページのURLを取得
#         next_page_url = doc.css(".next").css("a").attribute("href")
#         puts next_page_url
    
#     end
# end


#puts doc.css("#paginazione").css("li").empty?
# unless doc.css("paginazione").empty? then
#     #次のページのURLを取得
#     next_page_url = doc.css(".next").css("a").attribute("href")
#     puts next_page_url

# end


# 1.任意のクラス要素を取得する場合
# arraylist = doc.css("li")  配列として全て取得
# list_size = arraylist.size
# OO番目の要素を出力する
# puts arraylist[x]
# OO番目の要素内部にOOがあるか確認する
# puts arraylist[x].to_s.include?("OOOOO")



#2.nokogiriのポイント
#HTML上に無い要素を取得した場合は「空欄」扱いnilではない


#最初の要素を取得する場合 → .at
#doc.css('.js-product-miniature-wrapper').at("span").inner_text