require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#ruby prada_man_v.rb
class PradaVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby prada_man_v.rb
    @category = "アクセ"
    @price = "520"

    #include + クラス名
    include ColtortiMan
    include Amr
    include AmrFarfetchMan
    include AuzmendiFarfetchMan
    include Nugnes
    include Suit

    include Gb
    include Monti
    include Blondie

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://amrstore.com/collections/prada",
    "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=34624",
    "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&designer=34624",
    "https://www.coltortiboutique.com/it/designer/prada?cat=151",
    "https://suitnegozi.com/collections/prada-uomo",
    "https://nugnes1920.com/collections/prada-man",
    #selenium
    "https://www.gebnegozionline.com/it_it/uomo/designers/prada.html",
    "https://www.montiboutique.com/it-IT/Uomo/designer/prada",
    "https://www.blondieshop.com/it/uomo/man-designer/prada.html"
    ]

    vip_prada_man = PradaVipMan.new
    @price = PradaVipMan.call_price
    @category = PradaVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/it/shopping/men/G-B/items.aspx?view=90&scale=282&designer=34624" then
            vip_prada_man.gb_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/prada?cat=151" then
            vip_prada_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/men/wise-boutique/items.aspx?view=90&scale=282&designer=34624" then
            vip_prada_man.wise_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/prada-uomo" then
            vip_prada_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&designer=34624" then
            vip_prada_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/prada-man" then
            vip_prada_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #以下selenium
        when "https://www.gebnegozionline.com/it_it/uomo/designers/prada.html" 
            vip_prada_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Uomo/designer/prada" then
            vip_prada_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/uomo/man-designer/prada.html" then
            vip_prada_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end