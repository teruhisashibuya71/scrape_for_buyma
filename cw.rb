require 'rubygems'
require 'csv'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

url ="https://crowdworks.jp/login"
search_url ="https://crowdworks.jp/public/employees/ogroup/1?exclude_busy_employee=true&keywords=Ruby&page=25&skill_id=33%2C32&tab=occupation"
email = "lshibuya.tk@gmail.com"
pass = "setu1657"

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')
driver = Selenium::WebDriver.for :chrome , options: options
driver.get(url)
wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
wait.until { driver.find_element(:xpath => '//*[@id="Content"]/div/div/div[1]').displayed? }
driver.find_element(:xpath, '//*[@id="username"]').send_keys email
driver.find_element(:xpath, '//*[@id="password"]').send_keys email
sleep 1

driver.get(search_url)
sleep 2

#header = ['worker_url', 'price', 'work_time']
header = ['プロフィールURL','1週間の稼働時間', '時間単価']
rows = []

#csvファイルにヘッダーを記入
CSV.open("test.csv","w") do |csv|
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
    workers_data = driver.find_elements(:class_name, 'item')

    workers_data.each do |worker_data|
        #プロフィールURLを取得
        price = ""
        work_time = ""
        profile_url = worker_data.find_element(:tag_name, 'a').attribute('href')

        other_infomations = worker_data.find_elements(:tag_name, 'li')
        other_infomations.each do |info|
            if info.text.include?("稼働可能時間／週:") then
                work_time = info.text.delete("稼働可能時間／週:").strip!
            end
            if info.text.include?("時間単価:") then
                price = info.text.delete("時間単価:").delete(",").strip!
            end
        end
        rows << [profile_url, work_time, price]
        CSV.open('test.csv','a') do |csv|
            csv << rows
        end
        rows = []
    end
#end