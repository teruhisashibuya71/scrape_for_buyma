require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

brand_home_url = "https://www.blondieshop.com/it/donna/woman-designer/maison-margiela.html?in_stock=4380"
target_price = "3.500"

    #options = Selenium::WebDriver::Chrome::Options.new
    #options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome #, options: options
    driver.get(brand_home_url)
    sleep 3
    puts driver.find_element(:xpath, '//*[@id="page-title-heading"]/span').text #Maison Margiela

    12.times do # 一度だけはスクロールできないかもしれないので10回繰り返す
        sleep(1)
        driver.execute_script('window.scroll(0,1000000);') # 画面下までスクロールを実行
    end
    sleep(3)
    html_souce = driver.page_source
    puts html_souce
    puts driver.find_element(:xpath, '//*[@id="page-title-heading"]/span').text #Maison Margiela
    #puts html_souce.to_s #取得したソースを出力可能
    #スクロール

    #puts driver.find_element(:class  => "next").attribute("href")
    #puts driver.find_element(:class  => "next").attribute("href")
    #puts driver.find_element(:class, "pager").empty? #ドライバーに対して無い要素を指定するとエラー no scch a element


    #puts driver.find_elements(:class, "next").empty?
    #puts driver.find_elements(:class, "next").empty?
    #puts driver.find_elements(:class, "next").nil?