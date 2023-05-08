#セレニウムのテスト用ファイル
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

module BrunarossoMan

    # ログインを行うメソッド。VIP会員でしか確認できない商品を画面表示するために必要。
    # @param [driver] nokogiriで取得したHTML情報
    # @return [boolean] ログインの有無
    def selenium_login(driver, wait)
        #メルアド欄クリック
        el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[1]/div/div/div[2]/div[2]/div[1]/span[1]')
        el.click
        #メルアド入力してボタンをクリック
        el = driver.find_element(:xpath, '//*[@id="email"]')
        el.send_keys('lshibuya.ts@gmail.com')
        el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[1]/div/div/div[2]/div[2]/div[2]/div/div/div[2]/div/form/div/button')
        el.click
        #password欄が表示されるまで待つ
        wait.until { driver.find_element(:xpath, '//*[@id="password"]').displayed? }
        #パスワードを入力してloginボタンクリック
        el = driver.find_element(:xpath, '//*[@id="password"]')
        el.send_keys('setu1657')
        el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[1]/div/div/div[2]/div[2]/div[2]/div/div/div[2]/div/form/div[2]/div/button[1]')
        el.click
    end

    def scroll_brand_window(driver, target_brand_xpath)
        #表示されたらクリックしてjapanが表示される位置までスクロール
        driver.find_element(:class, "ManufacturerColumn").click
        womens_brand_list_window = driver.find_element(:class, "ManufacturerColumn")
        driver.action.move_by(womens_brand_list_window.location.x + 40, womens_brand_list_window.location.y + 40)
        
        # xpathで要素を取得する
        element = driver.find_element(:xpath, target_brand_xpath)
        # 要素までスクロールするスクリプトを実行する
        driver.execute_script("arguments[0].scrollIntoView();", element)
    end

    #折りたたみ command + option + [
    #展開 command + option + ]
    # クロール対象のブランド名に応じてブランドリンクをクリックするメソッド
    # @param [driver] nokogiriで取得したHTML情報
    # @param [brand_name] クロール対象のブランド名
    # @return [boolean] ログインの有無
    def select_brand_link(driver, brand_name, wait)
        case brand_name
        when "ALEXANDER_MCQUEEN"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[6]/a')
            el.click
            return true
        when "BALENCIAGA"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[6]/a')
            el.click
        when "BALMAIN"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[16]/a')
            el.click
        when "BOTTEGA_VENETA"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[24]/a')
            el.click
        when "CELINE"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[32]/a')
            el.click
        when "BURBERRY"
            selenium_login(driver)
            target_brand_xpath = '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[27]/a'
            scroll_brand_window(driver, target_brand_xpath)
            el = driver.find_element(:xpath, target_brand_xpath)
            el.click
            return true
        when "DOLCE_&_GABBANA"
            selenium_login(driver)
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[41]/a')
            el.click
            return true
        when "DSQUARED"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[43]/a')
            el.click
            return false
        when "FENDI"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[45]/a')
            el.click
        when "GIVENCHY"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[50]/a')
            el.click
        when "GOLDEN_GOOSE"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[51]/a')
            el.click
        when "HERNO"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[53]/a')
            el.click
        when "JIMMY_CHOO"
            target_brand_xpath = '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[64]/a'
            scroll_brand_window(driver, target_brand_xpath)
            el = driver.find_element(:xpath, target_brand_xpath)
            el.click
            return false
        when "JW_ANDERSON"
            scroll_brand_window(driver)
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[63]/a')
            el.click
            return false
        when "LANVIN"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[68]/a')
            el.click
        when "LOEWE"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[70]/a')
            el.click
        when "MARGIELA"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[72]/a')
            el.click
        when "MARNI"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[75]/a')
            el.click
        when "MM6"
            el = driver.find_element(:xpath, '')
            el.click
        when "MONCLER"
            el = driver.find_element(:xpath, '')
            el.click
        when "OFF_WHITE"
            el = driver.find_element(:xpath, '')
            el.click
        when "PALM_ANGELS"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[90]/a')
            el.click
            return false
        when "SAINT_LAURENT"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[97]/a')
            el.click
        when "STONE_ISLAND"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[103]/a')
            el.click
        when "STONE_ISLAND_SHADOW_PRJECT"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[104]/a')
            el.click
        when "TODS"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[108]/a')
            el.click
        when "TOM_FORD"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[109]/a')
            el.click
        when "VALENTINO" #VALENTINO GARAVANIもクロールする?
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[110]/a')
            el.click
        when "VALENTINO_GARAVANI"
            el = driver.find_element(:xpath, '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[111]/a')
            el.click
        when "VERSACE"  #VERSACE_HOMEも? #ログインなし
            target_brand_xpath = '//*[@id="__nuxt"]/div/div[3]/div[2]/div/div/div[2]/div[3]/ul/li[118]/a'
            scroll_brand_window(driver, target_brand_xpath)
            el = driver.find_element(:xpath, target_brand_xpath)
            el.clicK
        end
    end

    def brunarosso_onetime_crawl_selenium(doc, duty_free_price, is_login)
        products = doc.css('.ProductItem')
        products.each do |product|
            #ログインの有無で取得する価格を変更
            if (is_login) then
                item_price = product.css(".original-price").inner_text
            else
                item_price = product.css(".prod-price").inner_text
            end
            if (item_price.include?(duty_free_price)) then
                #puts item_price
                #puts product_name = product.css('h5').inner_text
                puts link_url = "https://www.brunarosso.com" + product.css('a').attribute("href").value
            end
        end
    end

    def brunarosso_crawl_selenium(brand_home_url, search_price, search_category, target_brand)
    
        #ヘッドレスバージョン
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for :chrome, {capabilities: [options]}
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        driver.manage.window.resize_to(1200,1000)

        #通常version
        # driver = Selenium::WebDriver.for :chrome
        # driver.manage.window.resize_to(1200,1000)
        # wait = Selenium::WebDriver::Wait.new(timeout: 15)
        #まずはブランドページへアクセス
        driver.get("https://www.brunarosso.com/designers")
        is_login = false

        #商品価格を免税価格に変更する 小数点以下は切り捨てでOK
        duty_free_price = search_price.to_i / 1.22
        duty_free_price = duty_free_price.floor.to_s

        #1000€以上はコンマを入れる
        if duty_free_price.length >= 4 then
            duty_free_price = duty_free_price.insert(1, ",")
        end
        
        #クーポンウインドウが表示されいる場合は削除
        if (driver.find_elements(:id, 'newsletter_pop').size != 0) then
            driver.execute_script('document.getElementsByClassName("close")[0].click()')
        end

        #もしかしたらこっちかも
        # if (driver.find_elements(:id, '__nuxt').size != 0) then
        #     driver.execute_script('document.getElementsByClassName("close")[0].click()')
        # end

        #ブランドリンクをクリックする
        is_login = select_brand_link(driver, target_brand, wait)

        sleep 5

        page_link_elements = driver.find_elements(:class, "page-item")

        #リンク数が1=商品ページが1ページだけの場合
        if (page_link_elements.size == 1) then
            #1回クローリングして処理を終了する
            doc = Nokogiri::HTML.parse(driver.page_source)
            brunarosso_onetime_crawl_selenium(doc, duty_free_price, is_login)
        else
            #クロールする回数を確認
            doc = Nokogiri::HTML.parse(driver.page_source)
            driver.execute_script("window.scrollTo(0, 2500);")
            sleep 1
            driver.execute_script('window.scrollBy(0, -300)')

            clowl_times = doc.at_css('.page-item:nth-last-child(2)').inner_text
            clowl_times = clowl_times.to_i - 1

            #回数が決まっている繰り返し処理を実行
            clowl_times.times do
                doc = Nokogiri::HTML.parse(driver.page_source)
                brunarosso_onetime_crawl_selenium(doc, duty_free_price, is_login)
                
                #次ページに移動するための処理 リンクを全て取得
                page_link_elements = driver.find_elements(:class, "page-item")
                #class名に「active」が付いているリンクの後続リンクが、要素の何番目になるのかを確認
                target_link_index = 0
                page_link_elements.each_with_index do |element, index|
                    if element.attribute("class").include?("active")
                        target_link_index = index + 1
                    end
                end

                #対象のリンクをクリックできるように画面下まで移動
                #ページの一番下まで移動
                driver.execute_script("window.scrollTo(0, 2500);")
                sleep 1
                driver.execute_script('window.scrollBy(0, -300)')
                #次ページのリンクをクリックしてページ遷移
                page_link_elements[target_link_index].click
                #商品が表示されるまで待つ
                #wait.until { driver.find_element(:class, 'CategoryList').displayed? }
                #上のソースではめずらしくtimeoutになるためsleepで対応  恐らくCategoryListは表示されっぱなしで対応できない
                sleep 5
            end
        end
    end
end