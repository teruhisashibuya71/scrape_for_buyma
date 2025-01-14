require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class LoeweVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby loewe_man_v.rb
    @category = "服"
    @price = "1800"
    include Actuelb,  Amr,  AmrFarfetchMan,  AuzmendiFarfetchMan,  ColtortiMan,  Gaudenzi,  Leam,  Michelefranzese,  Nugnes,  Russocapri,  Suit
    include Alducadaosta,  BrunarossoMan,  Blondie,  Eleonorabonucci,  Gb,  Monti,  Tessabit,  Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
    def self.call_currency
        @currency
    end

ATTACK_LIST_URL = [
    # なくなった"https://www.coltortiboutique.com/it/designer/loewe?cat=151",
    "https://www.leam.com/eu_en/designers/loewe?cat=59",
    "https://suitnegozi.com/collections/loewe-uomo",

    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/loewe",
    #"https://www.alducadaosta.com/it/uomo/designer/loewe_paulas_ibiza",
    #"https://brunarosso.com/designer/469-loewe-man",
    "https://www.gebnegozionline.com/it_it/uomo/designers/loewe.html",
    "http://specialshop.atelier98.net/it/uomo?idt=1980000516",
    
    "https://www.blondieshop.com/it/uomo/man-designer/loewe.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/loewe"
]

    loewe_vip_man = LoeweVipMan.new
    @price = LoeweVipMan.call_price
    @category = LoeweVipMan.call_category
    @currency = LoeweVipMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/loewe?cat=151"
            loewe_vip_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/loewe-uomo.html"
            loewe_vip_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/loewe-uomo"
            loewe_vip_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/loewe"
            loewe_vip_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://vip.brunarosso.com/s/designers/loewe/?category=men"
            loewe_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/loewe.html"
            loewe_vip_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/loewe.html"
            loewe_vip_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/loewe"
            loewe_vip_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/loewe.html"
            loewe_vip_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end

