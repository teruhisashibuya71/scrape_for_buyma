require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#https://www.cumini.com/en/shop_uomo?brand=prada
#spinnakerURL修正

class PradaNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby prada_man_n.rb
    @category = "アクセ"
    @price = "520"
    
    #include + クラス名
    include Cortecci
    include Ekseption
    include Grifo
    include Julian #0サイズあるよ
    include Lidia
    include LuisaWorld
    include Mycompanero
    include Ottodisapietro
    include Smets
    include Vietti
    
    #selenium
    include Credoman
    include Genteroma
    include Labels
    include Papini
    include Plline
    include Spinnaker
    
    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.julian-fashion.com/en-IT/men/designer/prada",
    "https://www.mycompanero.com/fr/brand/13-prada?categories=homme",
    "https://smets.lu/collections/prada/men",
    
    #selenium
    "https://www.genteroma.com/it/designer/uomo/prada.html",
    "https://www.pl-line.com/en/prada",
    "https://www.spinnakerboutique.com/en-IT/man/designer/prada"
]

    prada_n_man = PradaNormalMan.new
    @price = PradaNormalMan.call_price
    @category = PradaNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.julian-fashion.com/en-IT/men/designer/prada"
            prada_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")    
        when "https://www.mycompanero.com/fr/brand/13-prada?categories=homme"
            prada_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/prada/men"
            prada_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/prada"
            prada_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

            #以下selenium
        when "https://www.genteroma.com/it/designer/uomo/prada.html"
            prada_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.pl-line.com/en/prada"
            prada_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.com/en-IT/man/designer/prada"
            prada_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        end
    end

