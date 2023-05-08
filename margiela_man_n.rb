require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#https://sv77.com/eu/men/maison-margiela-designer/

#4/23 corsocomoまで改修済み 
class MargielaNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby margiela_man_n.rb
    @category = "服"
    @price = "3200"
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Julian, Lidia, LuisaWorld, Mycompanero, Ottodisapietro, Smets, Vietti
    include Bernardelli, Corsocomo, Credoman, Genteroma, Labels, Plline, Papini, Spinnaker, Vietti
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
    "https://www.aldogibilaro.com/en/10000330_maison-margiela",
    "https://www.ekseption.com/ot_en/designers/maison_margiela?cat=84",
    "https://grifo210.com/en/men/designers/maison-margiela.html",
    "https://www.julin-fashion.com/en-IT/men/designer/maison_margiela",
    "https://www.mycompanero.com/fr/brand/54-maison-margiela?categories=homme",
    "https://smets.lu/collections/maison-margiela/men",
    
    #以下selenium
    "https://www.bernardellistores.com/it/uomo/maison-margiela",
    "https://10corsocomo.com/collections/men?filter.p.vendor=MAISON%20MARGIELA"
    "https://www.genteroma.com/it/designer/uomo/maison-margiela.html",
    "https://shop.labelsfashion.com/men/designers/maison-margiela",
    "https://www.spinnakerboutique.com/it-IT/uomo/designer/maison_margiela",
    "https://www.papinistore.com/uomo-brand-maison-margiela",
    "https://www.viettishop.com/en/men/designers/maison-margiela"
    
    #Margiela × reebok
    #"https://www.viettishop.com/en/men/designers/maison-margiela-x-reebok"
    
]

margiela_n_man = MargielaNormalMan.new
@price = MargielaNormalMan.call_price
@category = MargielaNormalMan.call_category

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.aldogibilaro.com/en/10000330_maison-margiela"
        margiela_n_man.aldogibilaro_crawl(attack_site_url, @price)
        @price = @price.delete(".")   
    when "https://www.ekseption.com/ot_en/designers/maison_margiela?cat=84"
        margiela_n_man.ekseption_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://grifo210.com/en/men/designers/maison-margiela.html"
        margiela_n_man.grifo_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.julian-fashion.com/en-IT/men/designer/maison_margiela"
        margiela_n_man.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.mycompanero.com/fr/brand/54-maison-margiela?categories=homme"
        margiela_n_man.mycompanero_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://smets.lu/collections/maison-margiela/men"
        margiela_n_man.smets_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    
        #以下selenium
    when "https://www.bernardellistores.com/it/uomo/maison-margiela"
        margiela_n_man.bernardelli_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://10corsocomo.com/collections/men?filter.p.vendor=MAISON%20MARGIELA"
        margiela_n_man.corsocomo_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.genteroma.com/it/designer/uomo/maison-margiela.html"
        margiela_n_man.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://shop.labelsfashion.com/men/designers/maison-margiela"
        margiela_n_man.labels_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.papinistore.com/uomo-brand-maison-margiela"
        margiela_n_man.papini_crawl_selenium(attack_site_url, @price, @currency)
        #小数点削除必要無し
    when "https://www.spinnakerboutique.com/it-IT/uomo/designer/maison_margiela"
        margiela_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.viettishop.com/en/men/designers/maison-margiela"
        margiela_n_man.vietti_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    end
end



#https://www.dope-factory.com/collections/maison-margiela/
#https://www.wrongweather.net/jp//shop?o=&ord=desc&idfMar=142