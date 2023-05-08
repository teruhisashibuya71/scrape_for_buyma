require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#minetti eronora 調整済み
class VersaceVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby versace_m_v.rb
    @category = "アクセ"
    @price = "450"
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoMan, Blondie, Eleonorabonucci, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
ATTACK_LIST_URL = [
    "https://www.coltortiboutique.com/it/designer/versace?cat=151",
    "https://eleonorabonucci.com/en/versace/men/",
    "https://www.gaudenziboutique.com/en-it/men/designer/versace",
    "https://nugnes1920.com/collections/versace-man",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/versace",
    "https://www.minettiangeloonline.com/it/man?idt=128",
    "https://www.brunarosso.com/designer/611-versace-man",
    "https://www.gebnegozionline.com/it_it/uomo/designers/versace.html",
    "https://www.wiseboutique.com/it_it/uomo/designers/versace.html",
    "http://specialshop.atelier98.net/it/uomo?idt=1980000416"
]

    vip_versace_man = VersaceVipMan.new
    @price = VersaceVipMan.call_price
    @category = VersaceVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/versace?cat=151"
            vip_versace_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/versace/men/new-collection"
            vip_versace_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/men/designer/versace"
            vip_versace_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/versace-man"
            vip_versace_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/versace"
            vip_versace_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=128" 
            vip_versace_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/611-versace-man"
            vip_versace_man.brunarosso_crawl_selenium(attack_site_url, @price, @category, "VERSACE")
            #調整不要
        when "https://eleonorabonucci.com/en/versace/men/new-collection"
            vip_versace_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/versace.html"
            vip_versace_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo?idt=1980000416"
            vip_versace_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/uomo/designers/versace.html"
            vip_versace_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end