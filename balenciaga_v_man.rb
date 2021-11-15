require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

#require ./ファイル名
require './actuelb'
require './amr'
require './amr_f_man'
require './auzmendi_f_man'
require './coltorti_man'
require './gaudenzi'
require './gb_f_man'
require './leam'
require './nugnes'
require './russocapri'
require './sigrun'
require './suit'
require './wise_f_man' #monclerの価格違いあるので

#selenium系
require './alducadaosta'
require './brunarosso_man'
require './blondie'
require './eleonorabonucci'
require './gb'
require './monti'
require './tessabit'
require './wise'


class BalenciagaVipMan

    #brunarossoはログイン必要
    
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "1290"
    
    include Actuelb
    include Amr
    include AmrFarfetchMan
    include AuzmendiFarfetchMan
    include ColtortiMan
    include Gaudenzi
    include Leam
    include Nugnes
    include Russocapri
    include SigrunWoehr
    include Suit
    include WiseFarfetchMan

    #seleniumm系
    include Alducadaosta
    include BrunarossoMan
    include Blondie
    include Eleonorabonucci
    include Gb
    include Monti
    include Tessabit
    include Wise
    
    def self.call_category
        @category
    end

    def self.call_price
        @search_price
    end
    

ATTACK_LIST_URL = [
    "https://actuelb.com/en/55-men-s-balenciaga",
    "https://www.gaudenziboutique.com/en-it/men/designer/balenciaga",
    "https://www.leam.com/it_eu/designer/balenciaga-uomo.html",
    "https://nugnes1920.com/collections/balenciaga-man",
    "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=balenciaga",
    "https://suitnegozi.com/collections/balenciaga-uomo",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/balenciaga",
    #brunarosso login必要
    "https://www.blondieshop.com/it/uomo/man-designer/balenciaga.html",
    "https://www.gebnegozionline.com/it_it/uomo/designers/balenciaga.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/balenciaga",
    "https://www.tessabit.com/it_it/uomo/designers/balenciaga.html?page=1",
    
]

    balenciaga_vip_man = BalenciagaVipMan.new

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/55-men-s-balenciaga" then
            balenciaga_vip_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gaudenziboutique.com/en-it/men/designer/balenciaga" then
            balenciaga_vip_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/balenciaga-uomo.html" then
            balenciaga_vip_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/balenciaga-man" then
            balenciaga_vip_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=balenciaga" then
            balenciaga_vip_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://suitnegozi.com/collections/balenciaga-uomo" then
            balenciaga_vip_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/balenciaga" then
            balenciaga_vip_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "brunarosso" then
        #    balenciaga_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
        #    #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/balenciaga.html" then
            balenciaga_vip_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/balenciaga.html" then
            balenciaga_vip_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/balenciaga" then
            balenciaga_vip_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/balenciaga.html?page=1" then
            balenciaga_vip_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end