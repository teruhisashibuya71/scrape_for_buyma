require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

require './smets'


class JilsanderWoman

    #include + クラス名
    include Smets
    



    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "2150"
    #jilsander_woman = FendiVipWoman.new

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    #"https://smets.lu/collections/jil-sander"
    "https://www.michelefranzesemoda.com/it/donna/designer/jil-sander/"
]

    jilsander_woman = JilsanderWoman.new
    @price = JilsanderWoman.call_price
    @category = JilsanderWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://smets.lu/collections/jil-sander" then
            jilsander_woman.gb_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/donna/designer/jil-sander/" then
            jilsander_woman.gb_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end
