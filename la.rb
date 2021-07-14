require 'rubygems'
require 'csv'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

search_url ="https://www.lancers.jp/profile/search/system?industry_type_id=&type=&status=&visited=&age=&gender=&keyword=Ruby+on+Rails&not="

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')
driver = Selenium::WebDriver.for :chrome , options: options
driver.get(search_url)
wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
wait.until { driver.find_element(:xpath => '/html/body/div[3]/div[2]/main/div/section').displayed? }
#sleep 1

#header = ['worker_url', 'price', 'work_time']
header = ['プロフィールURL', '時間単価']
rows = []

#csvファイルにヘッダーを記入
CSV.open("lancers_test.csv","w") do |csv|
    csv << header
end



#is_next = driver.find_elements(:class_name, 'to_next_page')
##次ページへボタンがあるなら、クリックする
#if is_next.size == 1 then
#    
#puts is_next.size
##最終ページは size=0になる
#unless is_next.size == 0 then



    #配列上のワーカーデータを取得
    #workers_data = driver.find_elements(:css, 'member_item')
    workers_data = driver.find_elements(:class_name, 'c-media-list__item')
    workers_data.each do |worker_data|
        #プロフィールURLを取得
        profile_url = worker_data.find_elements(:tag_name, 'a')[0].attribute('href')
        price = worker_data.find_element(:class_name, 'c-status-list__item--sp-fluid').text.delete("希望時間単価").strip! #単価抜き出し完了
        rows << [profile_url, price]

        CSV.open('lancers_test.csv','a') do |csv|
            csv << rows
        end
        rows = []
    end
#end