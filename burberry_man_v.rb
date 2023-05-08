require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class BurberryVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby burberry_man_v.rb
    @category = "靴"
    @price = "820"
    @currency = 149.4
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoMan, Blondie, Gb, Monti, Tessabit, Wise
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
    "https://actuelb.com/en/492-men-s-burberry",
    "https://amrstore.com/collections/burberry",
    "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=769627",
    "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=769627",
    "https://www.coltortiboutique.com/it/designer/burberry?cat=151",
    "https://www.gaudenziboutique.com/en-it/men/designer/burberry",
    "https://www.leam.com/en/designer/burberry-men.html",
    "https://www.michelefranzesemoda.com/it/uomo/designer/burberry/",
    "https://nugnes1920.com/collections/burberry-man",
    "https://suitnegozi.com/collections/burberry-uomo",
#
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/burberry",
    "https://www.minettiangeloonline.com/it/man?idt=88",
    #"https://www.brunarosso.com/designer/366-burberry-man",
    "https://www.gebnegozionline.com/it_it/uomo/designers/burberry.html",
    "http://specialshop.atelier98.net/it/uomo-burberry",
    "https://www.wiseboutique.com/it_it/uomo/designers/burberry.html",
    "https://www.blondieshop.com/it/uomo/man-designer/burberry.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/burberry"
]

    vip_burberry_man = BurberryVipMan.new
    @price = BurberryVipMan.call_price
    @category = BurberryVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/492-men-s-burberry"
            vip_burberry_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/burberry"
            vip_burberry_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=769627"
            vip_burberry_man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=769627"
            vip_burberry_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/burberry?cat=151"
            vip_burberry_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/burberry"
            vip_burberry_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/burberry-men.html"
            vip_burberry_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/burberry/"
            vip_burberry_man.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/burberry-man"
            vip_burberry_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/burberry-uomo"
            vip_burberry_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/burberry"
            vip_burberry_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=88" 
            vip_burberry_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/burberry/?category=men"
            vip_burberry_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/burberry.html"
            vip_burberry_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/burberry.html"
            vip_burberry_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/burberry"
            vip_burberry_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo-burberry" 
            vip_burberry_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/uomo/designers/burberry.html"
            vip_burberry_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end
