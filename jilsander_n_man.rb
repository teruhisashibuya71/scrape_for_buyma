require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

# require './smets'
require './michelef'


class JilsanderMan

    #include + クラス名
    #include Smets
    include Michelefranzese
    



    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "575"
    #jilsander_woman = FendiVipWoman.new

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.michelefranzesemoda.com/it/uomo/designer/jil-sander/"
]

    jilsander_man = JilsanderMan.new
    @price = JilsanderMan.call_price
    @category = JilsanderMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
            when "https://www.michelefranzesemoda.com/it/uomo/designer/jil-sander/" then
                jilsander_man.michele_crawl(attack_site_url, @price)
                #@price = @price.delete(".")
            end
    end
