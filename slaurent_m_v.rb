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
require './leam'
require './michelef'
require './nugnes'
require './russocapri'
require './suit'
#require './wise_f_man' #monclerは価格違いがあるので

#selenium系
require './alducadaosta'
require './brunarosso_man'
require './blondie'
require './eleonorabonucci'
require './gb'
require './monti'
require './tessabit'
require './wise'


class SlVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "1690"
    
    include Actuelb
    include Amr
    include AmrFarfetchMan
    include AuzmendiFarfetchMan
    include ColtortiMan
    include Gaudenzi
    include Leam
    include Michelefranzese
    include Nugnes
    include Russocapri
    include Suit
    #include WiseFarfetchMan

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
        @price
    end

ATTACK_LIST_URL = [
    "https://www.coltortiboutique.com/it/designer/saint_laurent?cat=151",
    "https://www.gaudenziboutique.com/en-it/men/designer/saint_laurent",
    "https://www.leam.com/en/designer/saint-laurent-men.html",
    "https://www.michelefranzesemoda.com/it/uomo/designer/saint-laurent/",
    "https://nugnes1920.com/collections/saint-laurent-man",
    "https://suitnegozi.com/collections/saint-laurent-uomo",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/saint_laurent",
    "https://www.brunarosso.com/s/designers/saint-laurent/?category=men",
    "https://www.blondieshop.com/it/uomo/man-designer/saint-laurent.html",
    "https://eleonorabonucci.com/en/saint_laurent/men/new-collection",
    "https://eleonorabonucci.com/en/saint_laurent/men/sale",
    "https://www.gebnegozionline.com/it_it/uomo/designers/saint-laurent.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/saint_laurent",
    "https://www.tessabit.com/it_it/uomo/designers/saint-laurent.html?page=1",
    "https://www.wiseboutique.com/it_it/uomo/designers/saint-laurent.html"

]

    vip_stella_man = StellaVipMan.new
    @price = StellaVipMan.call_price
    @category = StellaVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/saint_laurent?cat=151"
            vip_stella_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/saint_laurent"
            vip_stella_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/saint-laurent-men.html"
            vip_stella_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/saint-laurent/"
            vip_stella_man.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://nugnes1920.com/collections/saint-laurent-man"
            vip_stella_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/saint-laurent-uomo"
            vip_stella_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/saint_laurent"
        vip_stella_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/saint-laurent/?category=men"
            vip_stella_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/saint-laurent.html"
            vip_stella_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/saint_laurent/men/new-collection"
            vip_stella_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #sell
        #when "https://eleonorabonucci.com/en/saint_laurent/men/sale"
        #  vip_stella_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        #  @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/saint-laurent.html"
            vip_stella_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/saint_laurent"
            vip_stella_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/saint-laurent.html?page=1"
            vip_stella_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/saint-laurent.html"
            vip_stella_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end