require 'rubygems'
require 'open-uri'
require 'selenium-webdriver'


brand_home_url = "https://www.brunarosso.com/s/designers/fendi/?category=men"

driver = Selenium::WebDriver.for :chrome #, options: options
driver.get(brand_home_url)
wait = Selenium::WebDriver::Wait.new(:timeout => 3) # second
wait.until { driver.find_element(:xpath => '//*[@id="center_column"]/div/div[2]/div[2]').displayed? }
puts driver.find_element(:xpath, '//*[@id="product-container-262664"]/div[2]')