#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

        #ヘッドレスバージョン
        #options = Selenium::WebDriver::Chrome::Options.new
        #options.add_argument('--headless')
        #driver = Selenium::WebDriver.for :chrome, options: options

        #対象のURL入力
        brand_home_url = "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/moncler-man"
        search_category  = "服"
        search_price  = "480"

        #クローム使う準備
        driver = Selenium::WebDriver.for :chrome
        #最大待ち時間を設定
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        #アクセス
        driver.get(brand_home_url)
        
        #LOADMOREボタンがクリックできるようになるまで待つ
        wait.until {driver.find_element(:class, 'secondary').enabled?}

        #puts driver.find_elements(:class, 'secondary').count
        puts driver.find_elements(:id, 'infinite-scroll-load-more').count
        driver.find_element(:id, 'infinite-scroll-load-more').click()


        #画面スライド
        driver.execute_script('window.scroll(0,3000);') # 画面下までスクロールを実行
        sleep 1
        
        wait.until {driver.find_element(:class, 'secondary').enabled?}
        puts driver.find_elements(:id, 'infinite-scroll-load-more').count
        driver.find_element(:id, 'infinite-scroll-load-more').click()
        driver.execute_script('window.scroll(0,3000);') # 画面下までスクロールを実行
        
        sleep 1

        wait.until {driver.find_element(:class, 'secondary').enabled?}
        puts driver.find_elements(:id, 'infinite-scroll-load-more').count
        driver.find_element(:id, 'infinite-scroll-load-more').click()
        driver.execute_script('window.scroll(0,3000);') # 画面下までスクロールを実行
        
        sleep 1
        
        # wait.until {driver.find_element(:class, 'secondary').enabled?}
        # puts driver.find_elements(:id, 'infinite-scroll-load-more').count
        # driver.find_element(:id, 'infinite-scroll-load-more').click()
        # driver.execute_script('window.scroll(0,3000);') # 画面下までスクロールを実行
        # sleep 1

        puts "繰り返し処理終了"

        doc = Nokogiri::HTML.parse(driver.page_source)

        puts doc.css('.product-item').size

        


        #ボタンが見えているかどうか?
        #element = driver.find_element_by_class_name('secondary')
        #element = driver.find_elements_by_class_name('page-title')
        #print(element.is_displayed())

        #LOADMOREボタンがクリックできるようになるまで待つ
        #ボタンを押す
        
        
