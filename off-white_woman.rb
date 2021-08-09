require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

require './smets'


class OffwhiteWoman

    #include + クラス名
    include Smets
    

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "790"
    #jilsander_woman = FendiVipWoman.new

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = ["https://smets.lu/collections/off-white/women"]

    offwhite_woman = OffwhiteWoman.new
    @price = OffwhiteWoman.call_price
    @category = OffwhiteWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://smets.lu/collections/off-white/women" then
            offwhite_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end
