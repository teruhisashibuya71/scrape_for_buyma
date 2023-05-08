require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#残りタスク1
#blondie オリジナルサイト farfetchにJIL SANDER表示ない
#https://www.blondieshop.com/it/woman/woman-designer/jil-sander.html

class JilsanderVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby jilsander_woman_v.rb
    @category = "服"
    @price = "200"
    @currency = 148.2
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Gb, Monti, Tessabit, Wise
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
    "https://actuelb.com/en/496-women-s-jil-sander",
    "https://www.coltortiboutique.com/it/designer/jil_sander?cat=166",
    "https://eleonorabonucci.com/en/jil_sander/women",
    #"https://eleonorabonucci.com/en/jil_sander/women/sale",
    "https://www.gaudenziboutique.com/en-it/women/designer/jil_sander",
    "https://www.leam.com/it_eu/designer/jil-sander-donna.html",
    "https://www.michelefranzesemoda.com/it/donna/designer/jil-sander/",
    "https://nugnes1920.com/collections/jil-sander-woman",
    "https://www.russocapri.com/it/donna/designer/jil-sander/gruppi",
    "https://suitnegozi.com/collections/jil-sander-donna",
    #selenium
    "https://www.minettiangeloonline.com/it/woman?idt=19",
    "https://www.brunarosso.com/s/designers/jil-sander/?category=women",
    "https://www.gebnegozionline.com/it_it/donna/designers/jil-sander.html",
    "https://www.wiseboutique.com/it_it/donna/designers/jil-sander.html",
    "http://specialshop.atelier98.net/it/donna?idt=830000010",
    "https://www.blondieshop.com/it/donna/woman-designer/jil-sander.html"
    
    ]

    vip_jilsander_woman = JilsanderVipWoman.new
    @price = JilsanderVipWoman.call_price
    @category = JilsanderVipWoman.call_category
    @currency = JilsanderVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/496-women-s-jil-sander"
            vip_jilsander_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/it/designer/jil_sander?cat=166"
            vip_jilsander_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/jil_sander/women"
            vip_jilsander_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        # when "https://eleonorabonucci.com/en/jil_sander/women/sale"
        #     vip_jilsander_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/jil_sander"
            vip_jilsander_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/donna/designer/jil-sander/"
            vip_jilsander_woman.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://www.leam.com/it_eu/designer/jil-sander-donna.html"
            vip_jilsander_woman.leam_crawl(attack_site_url, @price )
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/jil-sander-woman"
            vip_jilsander_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/designer/jil-sander/gruppi"
            vip_jilsander_woman.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/jil-sander-donna"
            vip_jilsander_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        
        #以下selenium
        when "https://www.minettiangeloonline.com/it/woman?idt=19" 
            vip_jilsander_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/donna/woman-designer/jil-sander.html"
            vip_jilsander_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")    
        when "https://www.brunarosso.com/s/designers/jil-sander/?category=women"
            vip_jilsander_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/jil-sander.html"
            vip_jilsander_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "" 
            vip_jilsander_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/jil-sander.html"
            vip_jilsander_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
