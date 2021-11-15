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


class StoneVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "747"
    
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

end

ATTACK_LIST_URL = [
    "https://www.farfetch.com/it/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=13198",
    "https://www.coltortiboutique.com/it/designer/stone_island?cat=151",
    "https://www.coltortiboutique.com/it/designer/stone_island_shadow_project?cat=151",
    "https://www.gaudenziboutique.com/en-it/men/designer/stone_island",
    "https://www.leam.com/en/designer/stone-island-men.html",
    "https://www.michelefranzesemoda.com/it/uomo/designer/stone-island/",
    "https://nugnes1920.com/collections/stone-island-man",
    "https://nugnes1920.com/collections/stone-island-shadow-project-man",
    "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=stone-island",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/stone_island",
    "https://www.alducadaosta.com/it/uomo/designer/stone_island_shadow",
    "https://www.brunarosso.com/s/designers/stone-island/?category=men",
    "https://www.brunarosso.com/s/designers/stone-island-shadow-project/?category=men",
    "https://www.blondieshop.com/it/uomo/man-designer/stone-island.html",
    "https://eleonorabonucci.com/en/stone_island/men/new-collection",
    "https://eleonorabonucci.com/en/stone-island-shadow-project/men/new-collection",
    "https://www.gebnegozionline.com/it_it/uomo/designers/stone-island.html",
    "https://www.tessabit.com/it_it/uomo/designers/stone-island.html?page=1",  
    "https://www.tessabit.com/it_it/uomo/designers/stone-island-shadow-project.html?page=1",  
    "https://www.wiseboutique.com/it_it/uomo/designers/stone-island.html"
]

    vip_stone_man = StoneVipMan.new
    @price = StoneVipMan.call_price
    @category = StoneVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/it/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=13198" 
            vip_stone_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/stone_island?cat=151"
            vip_stone_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/stone_island_shadow_project?cat=151"
            vip_stone_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/stone_island" 
            vip_stone_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/stone-island-men.html" 
            vip_stone_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/stone-island/"
            vip_stone_man.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://nugnes1920.com/collections/stone-island-man" 
            vip_stone_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/stone-island-shadow-project-man"
            vip_stone_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=stone-island" 
            vip_stone_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/stone_island" 
            vip_stone_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.alducadaosta.com/it/uomo/designer/stone_island_shadow" 
            vip_stone_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/stone-island/?category=men"
            vip_stone_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.brunarosso.com/s/designers/stone-island-shadow-project/?category=men"
            vip_stone_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/stone-island.html" 
            vip_stone_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/stone_island/men/new-collection"
            vip_stone_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/stone-island-shadow-project/men/new-collection"
            vip_stone_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")

        when "https://www.gebnegozionline.com/it_it/uomo/designers/stone-island.html" 
            vip_stone_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/stone-island.html?page=1" 
            vip_stone_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.tessabit.com/it_it/uomo/designers/stone-island-shadow-project.html?page=1" 
            vip_stone_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/stone-island.html" 
            vip_stone_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end