require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'


class DgVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby dg_man_v.rb
    @category = "靴"
    @price = "495"
    include Actuelb, Amr, AmrFarfetchMan, AngeloMinetti, AuzmendiFarfetchMan, ColtortiMan, Gaudenzi, Eleonorabonucci, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, BrunarossoMan, Blondie, Eleonorabonucci, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end

ATTACK_LIST_URL = [
    "https://amrstore.com/collections/dolce-gabbana",
    "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?page=1&view=90&sort=3&scale=282&designer=3440",
    "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?page=1&view=90&sort=3&scale=282&designer=3440",
    "https://www.coltortiboutique.com/it/designer/dolce_gabbana?cat=151",
    "https://eleonorabonucci.com/en/dolce_gabbana/men/new-collection",
    #"https://eleonorabonucci.com/en/dolce_gabbana/men/sale",
    "https://www.gaudenziboutique.com/en-it/men/designer/dolce_e_gabbana",
    "https://www.leam.com/it_eu/designer/dolce&gabbana-uomo.html",
    "https://nugnes1920.com/collections/dolce-gabbana-man",
    "https://suitnegozi.com/collections/dolce-gabbana-uomo",

    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/dolce_gabbana",
    "https://www.minettiangeloonline.com/it/man?idt=277",
    "https://www.brunarosso.com/s/designers/dolcegabbana/?category=men",
    "https://www.gebnegozionline.com/it_it/uomo/designers/dolce-gabbana.html",
    "https://www.wiseboutique.com/it_it/uomo/designers/dolce-gabbana.html",
    "http://specialshop.atelier98.net/it/uomo?idt=4",
    "https://www.blondieshop.com/it/uomo/man-designer/dolce-gabbana.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/dolce_and_gabbana"
]

vip_dg_man = DgVipMan.new
@price = DgVipMan.call_price
@category = DgVipMan.call_category

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
        when "https://amrstore.com/collections/dolce-gabbana"
            vip_dg_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?page=1&view=90&sort=3&scale=282&designer=3440"
            vip_dg_man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/dolce_gabbana/men/new-collection"
            vip_dg_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        # when "https://eleonorabonucci.com/en/dolce_gabbana/men/sale"
        #     vip_dg_man.eleonorabonucci_crawl(attack_site_url, @price)
        #     @price = @price.delete(",")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?page=1&view=90&sort=3&scale=282&designer=3440"
            vip_dg_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/dolce_gabbana?cat=151"
            vip_dg_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/dolce_e_gabbana"
            vip_dg_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/dolce&gabbana-uomo.html"
            vip_dg_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/dolce-gabbana-man"
            vip_dg_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/dolce-gabbana-uomo"
            vip_dg_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/dolce_gabbana"
            vip_dg_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=277"
            vip_dg_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/dolcegabbana/?category=men"
            vip_dg_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/dolce-gabbana.html"
            vip_dg_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/dolce-gabbana.html"
            vip_dg_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/dolce_and_gabbana"
            vip_dg_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo?idt=4"
            vip_dg_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/uomo/designers/dolce-gabbana.html"
            vip_dg_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end