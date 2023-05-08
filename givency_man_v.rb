require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class GivenchyVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby givency_man_v.rb
    @category = "服"
    @price = "2495"
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoMan, Blondie, Eleonorabonucci, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end

ATTACK_LIST_URL = [
    "https://actuelb.com/en/58-men-s-givenchy",
    "https://www.gaudenziboutique.com/en-it/men/designer/givenchy",
    "https://eleonorabonucci.com/en/givenchy/men/new-collection",
    #"https://eleonorabonucci.com/en/givenchy/men/sale",
    "https://www.michelefranzesemoda.com/it/uomo/designer/givenchy/",
    "https://nugnes1920.com/collections/givenchy-man",
    "https://www.russocapri.com/it/uomo/designer/givenchy/gruppi",
    "https://suitnegozi.com/collections/givenchy-uomo",

    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/givenchy",
    "https://www.minettiangeloonline.com/it/man-givenchy",
    "https://www.brunarosso.com/s/designers/givenchy/?category=men",    
    "https://www.gebnegozionline.com/it_it/uomo/designers/givenchy.html",
    "https://www.tessabit.com/it_it/man/designers/givenchy.html",
    "https://www.wiseboutique.com/it_it/uomo/designers/givenchy.html",
    "https://www.blondieshop.com/it/uomo/man-designer/givenchy.html"
]

    vip_givenchy_man = GivenchyVipMan.new
    @price = GivenchyVipMan.call_price
    @category = GivenchyVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/58-men-s-givenchy"
            vip_givenchy_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gaudenziboutique.com/en-it/men/designer/givenchy"
            vip_givenchy_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/givenchy/men/new-collection"
            vip_givenchy_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.michelefranzesemoda.com/it/uomo/designer/givenchy/"
            vip_givenchy_man.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://nugnes1920.com/collections/givenchy-man"
            vip_givenchy_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/designer/givenchy/gruppi"
            vip_givenchy_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://suitnegozi.com/collections/givenchy-uomo"
            vip_givenchy_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/givenchy"
            vip_givenchy_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man-givenchy" 
            vip_givenchy_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/givenchy/?category=men"
            vip_givenchy_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/givenchy.html"
            vip_givenchy_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/givenchy/men/new-collection"
            vip_givenchy_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/givenchy/men/sale"
            vip_givenchy_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/givenchy.html"
            vip_givenchy_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/givenchy.html"
            vip_givenchy_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/givenchy.html"
            vip_givenchy_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end