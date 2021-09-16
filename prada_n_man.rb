require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

#require './ファイル名'
require './ottodisapietro'



#ひとまず完成
#

class PradaMan

    #include + クラス名
    include Ottodisapietro

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "アクセ"
    @price = "2200"

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/prada-man"
    ]

    prada_man = PradaMan.new
    @price = PradaMan.call_price
    @category = PradaMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/prada-man" then
            prada_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end

    end

    
    
    
    
    
    