require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'selenium-webdriver'

#brand_home_url = "https://www.montiboutique.com/it-IT/uomo/designer/gucci"
brand_home_url = "https://www.montiboutique.com/it-IT/Uomo/designer/fendi/borse"
target_price = "3500"

    #options = Selenium::WebDriver::Chrome::Options.new
    #options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome #, options: options
    driver.get(brand_home_url)
    sleep 1
    #puts driver.find_element(:class  => "next").attribute("href")
    
    puts driver.find_elements(:class, "next").empty?
    puts driver.find_elements(:class, "next").nil?
    wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
    wait.until { driver.find_element(:xpath => "/html/body/footer/section").displayed? }
    country = driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").text
    if !country.include?("ITALY") then
        #クッキーウインドウのクリック
        sleep 0.5
        driver.execute_script('document.getElementsByClassName("accept")[0].click()')
        #発送国→Japanをクリックして国選択画面へ移動
        driver.execute_script('document.getElementsByClassName("brg-btn-green")[0].click()')
        driver.get(brand_home_url)
        wait.until { driver.find_element(:class => "links").displayed? }
        driver.find_element(:xpath, '/html/body/footer/section/ul[4]/li[3]/a/span').click
# 
        #発送地域が全て表示されるまで待ってからeuropeをクリック
        wait.until { driver.find_element(:class => "left").displayed? }
        driver.find_element(:xpath, '/html/body/div[3]/form/div/div[1]/h5[1]').click
        #仕方がないのでsleepでで対応
        sleep 1
# 
        #国の名前が表示されるまで待ってitalyをクリック
        wait.until { driver.find_element(:id => 'zona-1').enabled? }
        driver.find_element(:xpath, '//*[@id="zona-1"]/ul/li[27]/label').click
# 
        #wait.until { driver.find_element(:class => "stage").displayed? }
        #→€クリック
        driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/div[1]/ul/li[4]/label').click
        #wait.until { driver.find_element(:class => "stage").displayed? }
        #saveボタンクリック
        driver.find_element(:xpath, '/html/body/div[3]/form/div/div[2]/button').click
        wait.until { driver.find_element(:xpath => "/html/body/footer/section/ul[4]/li[3]/a/span").displayed? }
        #フェンディ(brand_home_url)の画面に移動する
        #driver.get(brand_home_url)
        #商品が表示されるまで待つ
        #wait.until { driver.find_element(:class => "list-box").displayed? }
    end
# 
    category_url = brand_home_url + "/abbigliamento"
    driver.get(category_url)
    products = driver.find_elements(:class => "products")
    products.each do |product|
        item_price = product.find_element(:class => "price").text
        if item_price.include?(target_price) then
            puts item_price = product.find_element(:class => "price").text
            puts product_name = product.find_element(:class => "name").text
            puts product.find_element(:tag_name => "a").attribute("href")
        end
    end
# 
# 
# 
    # doc.css(".product-item").each do |product|
    #    #商品価格を取得する
    #    item_price = product.css(".product-price").inner_text
    #    if item_price.include?(target_price) then
    #        #商品価格 商品名 画像リンク を取得する
    #        puts item_price.strip
    #        puts product.css(".description-item").text
    #        puts product.css('a').attribute("href").value
    #    end
    # end



#sllepして要素の取得が可能かどうか確認している  GBのプラダ-カテゴリー服のURLでテスト
#ページが存在しない場合、page1のURLに飛ばされてクローリングしちゃう
#


#doc = Nokogiri::HTML.parse(url, nil, 'utf-8')
#puts doc
##空欄になるはず
#puts result = doc.xpath('//*[@id="maincontent"]/div[4]/div/div[3]/div/div[2]/ul/li[3]/a/span[1]')
#puts result.empty?


#スクレイピング開始する
#charset = nil
#html = open(url) do |f|
#    charset = f.charset
#    f.read
#end
#doc = Nokogiri::HTML.parse(html, nil, charset)
#
#
#puts pagewise = doc.css(".next")
#puts pagewise.empty?

##shipping to JAPANと120品表示に切り替えを行うメソッド
#    def prepare_crowl(brand_home_url)
#        options = Selenium::WebDriver::Chrome::Options.new
#        options.add_argument('--headless')
#        driver = Selenium::WebDriver.for :chrome, options: options
#        driver.navigate.to brand_home_url
#        wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
#        wait.until { driver.find_element(:class => "scolumns").displayed? }
#        #puts driver.page_source.class #String型
#        #puts driver.class #String型
#        #puts driver.find_elements(:class => "product-item")
#        products = driver.find_elements(:class => "product-item")
#        products.each do |product|
#            item_price = product.find_element(:class => "price") #inner_textは使えない
#            puts item_price.text #中身の表示は.textメソッド
#            puts product.find_element(:tag_name, 'a').attribute("href")  #(:tag_name, 'タグ名').attribute("href")
#        end
#    end



#①nokogiriの基本構文
# #最初のaタグを取得する構文を考えるところから
# #puts doc.css('.categories').css('a')[0].attribute("href")
# #puts !doc.css('.next').inner_text.empty?
# #puts doc.css('.pager').css('a').value
# #puts doc.css('.pager').css('a').attr('class').to_s == "next"
# #puts doc.css('.pager').css('a').size
# #puts doc.css('.pager').css('a')[0].attr('class').to_s == "prev"
# puts doc.css('.next').css('a').attribute("href")
#puts doc.css('categories[title="abbigliamento"]')


#②seleniumの基本構文
#クラス指定の場合でも クラス名の前にドットは必要無いので注意が必要
#driver.find_element(:class => "product-item") #指定のクラスの最初の要素を取得

#クラス名による要素の取得
#driver.find_element(:class => "product-item").text #指定のクラスの要素を出力
#driver.find_elements(:class => "product-item") #指定のクラスの全ての要素を配列で取得
#driver.find_elements(:class_name, 'item') この書き方もOK


#間違った記述  エラーすら出ないので注意が必要
#driver.find_elements(:class, 'item')

#タグ名での取得
#find_element(:tag_name, 'a').attribute('href') OK href要素を取得する場合は(tag_name => 'a')に持ち込める状態まで分解すること
#find_element(:tag_name, => 'a').attribute('href') たぶんOK


#2つの違いを理解すること
#find_element 存在しない要素を取得しようとするとエラーになる
#find_elements 存在しない要素を取得しると空欄になる

