require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#ruby bottega_v_man.rb
class BottegaVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby bottega_man_v.rb
    @category = "アクセ"
    @price = "420"
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoMan, Blondie, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end

ATTACK_LIST_URL = [
    "https://www.coltortiboutique.com/it/designer/bottega_veneta?cat=151",
    "https://eleonorabonucci.com/en/bottega-veneta/men",
    "https://www.gaudenziboutique.com/en-it/men/designer/bottega_veneta",
    "https://www.leam.com/it_eu/designer/bottega-veneta-uomo.html",
    "https://nugnes1920.com/collections/bottega-veneta-man",
    "https://suitnegozi.com/collections/bottega-veneta-uomo",
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/bottega_veneta",
    "https://www.minettiangeloonline.com/it/man?idt=384",
    "https://www.brunarosso.com/s/designers/bottega-veneta/?category=men",
    "https://www.gebnegozionline.com/it_it/uomo/designers/bottega-veneta.html",
    "https://www.blondieshop.com/it/uomo/man-designer/bottega-veneta.html",
    "https://www.tessabit.com/it_it/uomo/designers/bottega-veneta.html"
    #"https://www.montiboutique.com/it-IT/uomo/designer/bottega_veneta",
]

    vip_bottega_man = BottegaVipMan.new
    @price = BottegaVipMan.call_price
    @category = BottegaVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/bottega_veneta?cat=151"
            vip_bottega_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/bottega-veneta/men"
            vip_bottega_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/bottega_veneta"
            vip_bottega_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/bottega-veneta-uomo.html"
            vip_bottega_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/bottega-veneta-man"
            vip_bottega_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/bottega-veneta-uomo"
            vip_bottega_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/bottega_veneta"
            vip_bottega_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=384" 
            vip_bottega_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/bottega-veneta/?category=men"
            vip_bottega_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/bottega-veneta.html"
            vip_bottega_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/bottega-veneta.html"
            vip_bottega_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #when #"https://www.montiboutique.com/it-IT/uomo/designer/bottega_veneta"
        #    vip_bottega_man.monti_crawl_selenium(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/bottega-veneta.html"
            vip_bottega_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end