require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class OffwhiteVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby off_man_v.rb
    @category = "アクセ"
    @price = "315"
    
    #nokogiri seleniumm
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Gaudenzi, Leam, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchMan
    include Alducadaosta, BrunarossoMan, Blondie, Eleonorabonucci, Gb, Monti, Tessabit, Wise

    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    "https://actuelb.com/en/424-men-s-off-white",
    "https://amrstore.com/collections/off-white",
    "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=1205035",
    "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=1205035",
    "https://www.coltortiboutique.com/it/designer/off_white?cat=151",
    "https://eleonorabonucci.com/en/off-white/men/new-collection",
    "https://www.gaudenziboutique.com/en-it/men/designer/off_white",
    "https://www.leam.com/en/designer/off-white-men.html",
    "https://nugnes1920.com/collections/off-white-man",
    "https://www.russocapri.com/it/uomo/designer/off-white/gruppi",
    "https://suitnegozi.com/collections/off-white-uomo",  
    #selenium
    "https://www.alducadaosta.com/it/uomo/designer/offwhite",
    "https://www.brunarosso.com/s/designers/off-white/?category=men",
    "https://www.gebnegozionline.com/it_it/uomo/designers/off-white.html",
    "https://www.wiseboutique.com/it_it/uomo/designers/off-white.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/off_white",
    "https://www.blondieshop.com/it/uomo/man-designer/off-white.html",
    "https://www.tessabit.com/it_it/uomo/designers/off-white.html?page=1"  
]

vip_offwhite_man = OffwhiteVipMan.new
@price = OffwhiteVipMan.call_price
@category = OffwhiteVipMan.call_category

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://actuelb.com/en/424-men-s-off-white" then
        vip_offwhite_man.actuel_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://amrstore.com/collections/off-white" then
        vip_offwhite_man.amr_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=1205035" then
        vip_offwhite_man.amr_farfetch_crawl(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=1205035" then
        vip_offwhite_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.coltortiboutique.com/it/designer/off_white?cat=151" then
        vip_offwhite_man.coltorti_crawl(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://eleonorabonucci.com/en/off-white/men/new-collection"
        vip_offwhite_man.eleonorabonucci_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.gaudenziboutique.com/en-it/men/designer/off_white" then
        vip_offwhite_man.gaudenzi_crawl(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.leam.com/en/designer/off-white-men.html" then
        vip_offwhite_man.leam_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://nugnes1920.com/collections/off-white-man" then
        vip_offwhite_man.nugnes_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.russocapri.com/it/uomo/designer/off-white/gruppi"
        vip_offwhite_man.russo_crawl(attack_site_url, @price)
        #価格調整無し
    when "https://suitnegozi.com/collections/off-white-uomo"
        vip_offwhite_man.suit_crawl(attack_site_url, @price)
        @price = @price.delete(".")
        
    #以下selenium
    when "https://www.alducadaosta.com/it/uomo/designer/offwhite"
        vip_offwhite_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.brunarosso.com/s/designers/off-white/?category=men"
        vip_offwhite_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
        #調整不要
    when "https://www.blondieshop.com/it/uomo/man-designer/off-white.html"
        vip_offwhite_man.blondie_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.gebnegozionline.com/it_it/uomo/designers/off-white.html"
        vip_offwhite_man.gb_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.montiboutique.com/it-IT/uomo/designer/off_white"
        vip_offwhite_man.monti_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.tessabit.com/it_it/uomo/designers/off-white.html?page=1"
        vip_offwhite_man.tessabit_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.wiseboutique.com/it_it/uomo/designers/off-white.html"
        vip_offwhite_man.wise_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(",")
    end
end