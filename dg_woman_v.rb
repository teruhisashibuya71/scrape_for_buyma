require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class DgVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby dg_woman_v.rb
    @category = "服"
    @price = "795"
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
ATTACK_LIST_URL = [
    "https://amrstore.com/collections/dolce-gabbana",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?page=1&view=90&sort=3&scale=274&designer=3440",
    "https://www.coltortiboutique.com/it/designer/dolce_gabbana?ca_gender=1997",
    "https://eleonorabonucci.com/en/dolce_gabbana/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/dolce_e_gabbana",
    "https://www.leam.com/it_eu/designer/dolce&gabbana-donna.html",
    "https://nugnes1920.com/collections/dolce-gabbana-woman",
    "https://www.farfetch.com/it/shopping/women/sigrun-woehr/items.aspx?page=1&view=90&sort=3&scale=274&designer=3440",
    "https://suitnegozi.com/collections/dolce-gabbana-donna",
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/dolce___gabbana",
    "https://www.minettiangeloonline.com/it/woman?idt=277",
    "https://www.brunarosso.com/designer/396-dolcegabbana-woman",
    "https://www.gebnegozionline.com/it_it/donna/designers/dolce-gabbana.html",
    "http://specialshop.atelier98.net/it/donna?idt=4",
    "https://www.wiseboutique.com/it_it/donna/designers/dolce-gabbana.html",
    "https://www.blondieshop.com/it/donna/woman-designer/dolce-gabbana.html",
    "https://www.montiboutique.com/it-IT/donna/designer/dolce_and_gabbana"
]

    vip_dg_woman = DgVipWoman.new
    @price = DgVipWoman.call_price
    @category = DgVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/dolce-gabbana"
            vip_dg_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?page=1&view=90&sort=3&scale=274&designer=3440"
            vip_dg_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/dolce_gabbana?ca_gender=1997"
            vip_dg_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/dolce_gabbana/women"
            vip_dg_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gaudenziboutique.com/en-it/women/designer/dolce_e_gabbana"
            vip_dg_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/dolce&gabbana-donna.html"
            vip_dg_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/dolce-gabbana-woman"
            vip_dg_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/sigrun-woehr/items.aspx?page=1&view=90&sort=3&scale=274&designer=3440"
            vip_dg_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/dolce-gabbana-donna"
            vip_dg_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/dolce___gabbana"
            vip_dg_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=277" 
            vip_dg_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/396-dolcegabbana-woman"
            vip_dg_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/dolce-gabbana.html"
            vip_dg_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/dolce-gabbana.html"
            vip_dg_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/dolce_and_gabbana"
            vip_dg_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=4"
            vip_dg_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/dolce-gabbana.html"
            vip_dg_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end