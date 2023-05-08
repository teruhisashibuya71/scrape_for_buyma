require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class StoneVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby stone_v.rb
    @category = "服"
    @price = "275"
    @currency = 145.3
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
end

ATTACK_LIST_URL = [
    "https://www.farfetch.com/it/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=13198",
    "https://www.coltortiboutique.com/it/designer/stone_island?cat=151",
    "https://eleonorabonucci.com/en/stone_island/men/new-collection",
    "https://www.gaudenziboutique.com/en-it/men/designer/stone_island",
    "https://www.leam.com/en/designer/stone-island-men.html",
    "https://www.michelefranzesemoda.com/it/uomo/designer/stone-island/",
    "https://nugnes1920.com/collections/stone-island-man",
    "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=stone-island",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/stone_island",
    "https://www.minettiangeloonline.com/it/man?idt=82",
    #"https://www.brunarosso.com/s/designers/stone-island/?category=men",
    "https://www.gebnegozionline.com/it_it/uomo/designers/stone-island.html",
    "http://specialshop.atelier98.net/it/uomo?idt=1980000234",  
    "https://www.wiseboutique.com/it_it/uomo/designers/stone-island.html",
    "https://www.blondieshop.com/it/uomo/man-designer/stone-island.html"

    #以下 shadowPrject
    #"https://www.coltortiboutique.com/it/designer/stone_island_shadow_project?cat=151",
    #"https://nugnes1920.com/collections/stone-island-shadow-project-man",
    #"https://eleonorabonucci.com/en/stone-island-shadow-project/men/new-collection",
    #"https://www.alducadaosta.com/it/uomo/designer/stone_island_shadow",
    #"https://www.minettiangeloonline.com/it/man?idt=407",
    #"https://www.brunarosso.com/s/designers/stone-island-shadow-project/?category=men",
    #"https://www.tessabit.com/it_it/uomo/designers/stone-island-shadow-project.html?page=1",
]

    vip_stone_man = StoneVipMan.new
    @price = StoneVipMan.call_price
    @category = StoneVipMan.call_category
    @currency = StoneVipMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/it/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=13198" 
            vip_stone_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/stone_island?cat=151"
            vip_stone_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/stone_island/men/new-collection"
            vip_stone_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/stone_island" 
            vip_stone_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/stone-island-men.html" 
            vip_stone_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/stone-island/"
            vip_stone_man.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/stone-island-man" 
            vip_stone_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=stone-island" 
            vip_stone_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/stone_island" 
            vip_stone_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=82" 
            vip_stone_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        # when ""
        #     vip_stone_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
        #     #調整不要
        when "https://eleonorabonucci.com/en/stone-island-shadow-project/men/new-collection"
            vip_stone_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/stone-island.html" 
            vip_stone_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo?idt=1980000234" 
            vip_stone_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/stone-island.html" 
            vip_stone_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")


        #以下shadow
        when "https://www.coltortiboutique.com/it/designer/stone_island_shadow_project?cat=151"
            vip_stone_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/stone-island-shadow-project-man"
            vip_stone_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.alducadaosta.com/it/uomo/designer/stone_island_shadow" 
            vip_stone_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=407" 
            vip_stone_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        # when "https://www.brunarosso.com/s/designers/stone-island-shadow-project/?category=men"
        #     vip_stone_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
        #     #調整不要
        end
    end