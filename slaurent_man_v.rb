require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class SlVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby slaurent_man_v.rb
    @category = "バッグ"
    @price = "2850"
    @currency = 146.3
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoMan, Blondie, Eleonorabonucci, Gb, Monti, Tessabit, Wise
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
    "https://www.coltortiboutique.com/it/designer/saint_laurent?ca_gender=1996",
    "https://eleonorabonucci.com/en/saint_laurent/men/new-collection",
    #"https://eleonorabonucci.com/en/saint_laurent/men/sale",
    "https://www.gaudenziboutique.com/en-it/men/designer/saint_laurent",
    "https://www.leam.com/it_eu/designer/saint-laurent-uomo.html",
    "https://www.michelefranzesemoda.com/it/uomo/designer/saint-laurent/",
    "https://nugnes1920.com/collections/saint-laurent-man",
    "https://suitnegozi.com/collections/saint-laurent-uomo",
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/saint_laurent",
    "https://www.minettiangeloonline.com/it/man?idt=90",
    #"https://www.brunarosso.com/designer/562-saint-laurent-man",
    "https://www.wiseboutique.com/it_it/uomo/designers/saint-laurent.html",
    "https://www.gebnegozionline.com/it_it/uomo/designers/saint-laurent.html",
    "http://specialshop.atelier98.net/it/uomo?idt=1980000006",
    "https://www.blondieshop.com/it/uomo/man-designer/saint-laurent.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/saint_laurent" #止まるので注意
    
]

    vip_sl_man = SlVipMan.new
    @price = SlVipMan.call_price
    @category = SlVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/saint_laurent?ca_gender=1996"
            vip_sl_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/saint_laurent/men/new-collection"
            vip_sl_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        #sell品
        # when "https://eleonorabonucci.com/en/saint_laurent/men/sale"
        #     vip_sl_man.eleonorabonucci_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/saint_laurent"
            vip_sl_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/saint-laurent-uomo.html"
            vip_sl_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/saint-laurent/"
            vip_sl_man.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/saint-laurent-man"
            vip_sl_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/saint-laurent-uomo"
            vip_sl_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/saint_laurent"
            vip_sl_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=90"
            vip_sl_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/562-saint-laurent-man"
            vip_sl_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/saint-laurent.html"
            vip_sl_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/saint-laurent.html"
            vip_sl_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/saint_laurent"
            vip_sl_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo?idt=1980000006"
            vip_sl_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/saint-laurent.html"
            vip_sl_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end