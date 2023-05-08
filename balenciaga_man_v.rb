require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class BalenciagaVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby balenciaga_man_v.rb
    @category = "アクセ"
    @price = "1600"

    include Actuelb, Amr,AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan,Gaudenzi,Leam, Nugnes, Russocapri, Suit
    include Alducadaosta, BrunarossoMan, Blondie, Eleonorabonucci, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @search_price
    end

ATTACK_LIST_URL = [
    "https://actuelb.com/en/55-men-s-balenciaga",
    "https://eleonorabonucci.com/en/balenciaga/men",
    "https://www.gaudenziboutique.com/en-it/men/designer/balenciaga",
    "https://www.leam.com/it_eu/designer/balenciaga-uomo.html",
    "https://nugnes1920.com/collections/balenciaga-man",
    #"https://www.russocapri.com/it/uomo/designer/balenciaga/gruppi",
    "https://suitnegozi.com/collections/balenciaga-uomo",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/balenciaga",
    "https://www.minettiangeloonline.com/it/man?idt=4"
    "https://www.brunarosso.com/s/designers/balenciaga/?category=men",
    "https://www.gebnegozionline.com/it_it/uomo/designers/balenciaga.html",
    "http://specialshop.atelier98.net/it/uomo?idt=1980000003",
    "https://www.blondieshop.com/it/uomo/man-designer/balenciaga.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/balenciaga"
]

    balenciaga_vip_man = BalenciagaVipMan.new

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/55-men-s-balenciaga" 
            balenciaga_vip_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://eleonorabonucci.com/en/balenciaga/men"
            balenciaga_vip_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/sen-it/men/designer/balenciaga" 
            balenciaga_vip_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/balenciaga-uomo.html" 
            balenciaga_vip_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/balenciaga-man" 
            balenciaga_vip_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/designer/balenciaga/gruppi"
            balenciaga_vip_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://suitnegozi.com/collections/balenciaga-uomo" 
            balenciaga_vip_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/balenciaga" 
            balenciaga_vip_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/balenciaga/?category=men"
            balenciaga_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/balenciaga.html" 
            balenciaga_vip_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/balenciaga.html" 
            balenciaga_vip_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/balenciaga" 
            balenciaga_vip_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/balenciaga.html?page=1" 
            balenciaga_vip_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end