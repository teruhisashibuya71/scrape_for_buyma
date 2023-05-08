require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#angelo / tessabit 完了
class JilsanderVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby jilsander_man_v.rb
    @category = "服"
    @price = "545"
    @currency = 142.4
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
    "https://actuelb.com/en/1939-men-s-jil-sander",
    "https://www.coltortiboutique.com/en/designer/jil_sander?ca_gender=1996"
    "https://eleonorabonucci.com/en/jil_sander/men/new-collection",
    #"https://eleonorabonucci.com/en/jil_sander/men/sale",
    "https://www.gaudenziboutique.com/en-it/men/designer/jil_sander",
    "https://www.michelefranzesemoda.com/it/uomo/designer/jil-sander/",
    "https://nugnes1920.com/collections/jil-sander-man",
    "https://suitnegozi.com/collections/jil-sander-uomo",

    #selenium
    "https://www.minettiangeloonline.com/it/man?idt=19",
    "https://www.gebnegozionline.com/it_it/uomo/designers/jil-sander.html",
    "https://www.wiseboutique.com/it_it/uomo/designers/jil-sander.html",
    "https://www.blondieshop.com/it/uomo/man-designer/jil-sander.html?p=2",
    "http://specialshop.atelier98.net/it/uomo?idt=830000010"
]

    vip_jilsander_man = JilsanderVipMan.new
    @price = JilsanderVipMan.call_price
    @category = JilsanderVipMan.call_category
    @currency = JilsanderVipMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/1939-men-s-jil-sander"
            vip_jilsander_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/en/designer/jil_sander?ca_gender=1996"
            vip_jilsander_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/jil_sander/men/new-collection"
            vip_jilsander_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/men/designer/jil_sander"
            vip_jilsander_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/jil-sander/"
            vip_jilsander_man.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/jil-sander-man"
            vip_jilsander_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/jil-sander-uomo"
            vip_jilsander_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.blondieshop.com/it/uomo/man-designer/jil-sander.html"
            vip_jilsander_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=19" 
            vip_jilsander_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/jil-sander.html"
            vip_jilsander_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo?idt=830000010"
            vip_jilsander_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "tessabit"
            vip_jilsander_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/jil-sander.html"
            vip_jilsander_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end


# https://suitnegozi.com/collections/jil-sander-uomo
# https://nugnes1920.com/collections/jil-sander-man
# https://www.gebnegozionline.com/it_it/uomo/designers/jil-sander.html
# https://www.wiseboutique.com/it_it/uomo/designers/jil-sander.html
# https://www.blondieshop.com/it/uomo/man-designer/jil-sander.html?p=2

# https://eleonorabonucci.com/en/jil_sander/men/new-collection
# https://eleonorabonucci.com/en/jil_sander/men/sale
# https://www.gaudenziboutique.com/en-it/men/designer/jil_sander

# https://www.michelefranzesemoda.com/it/uomo/designer/jil-sander/
# https://www.tessabit.com/it_it/uomo/designers/jil-sander.html

