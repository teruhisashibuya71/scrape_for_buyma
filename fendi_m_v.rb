require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

#require ./ファイル名
#require './actuelb'
#require './amr'
#require './amr_f_man'
#require './auzmendi_f_man'
require './coltorti_man'
require './gaudenzi'
require './gb_f_man'
#require './leam'
require './nugnes'
#require './russocapri'
require './suit'
#include Wise_F_man

#selenium系
require './alducadaosta'
require './brunarosso_man'
#require './blondie'
#require './eleonorabonucci'
require './gb'
require './monti'
require './tessabit'
require './wise'


class FendiVip

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "795"

    #include Actuelb
    #include Amr
    #include AmrFarfetchMan
    #include AuzmendiFarfetchMan
    include ColtortiMan
    include Gaudenzi
    #include Leam なくなった
    include Nugnes
    #include Russocapri
    include Suit
    #include WiseFarfetchMan

    #seleniumm系
    include Alducadaosta
    include BrunarossoMan
    #include Blondie
    #include Eleonorabonucci
    include Gb
    include Monti
    include Tessabit
    include Wise

    ATTACK_LIST_URL = [
        "https://www.coltortiboutique.com/it/designer/fendi?cat=151",
        "https://www.gaudenziboutique.com/en-it/men/designer/fendi",
        "https://nugnes1920.com/collections/fendi-man",
        "https://suitnegozi.com/collections/fendi-uomo",
        
        #以下selenium
        "https://www.alducadaosta.com/it/uomo/designer/fendi",
        "https://www.brunarosso.com/s/designers/fendi/?category=men",
        "https://www.gebnegozionline.com/it_it/uomo/designers/fendi.html",
        "https://www.montiboutique.com/it-IT/Uomo/designer/fendi",
        "https://www.tessabit.com/it_it/uomo/designers/fendi.html?page=1",        
        "https://www.wiseboutique.com/it_it/uomo/designers/fendi.html"
    ]

    

    def self.call_price
        @price
    end

    fendi_vip = FendiVip.new

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=151" then
            fendi_vip.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/fendi" then
            fendi_vip.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/fendi-man" then
            fendi_vip.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/fendi-uomo" then
            fendi_vip.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/fendi" then
            fendi_vip.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/fendi/?category=men" then
            fendi_vip.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #価格調整無し
        when "https://www.montiboutique.com/it-IT/Uomo/designer/fendi" then
            fendi_vip.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/uomo/designers/Fendi" then
            fendi_vip.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/fendi.html" then
            fendi_vip.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end
end