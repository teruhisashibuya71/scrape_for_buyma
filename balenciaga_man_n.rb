require 'rubygems'
require 'nokogiri'
require 'open-uri'
require_all '/Users/ts/Desktop/scrape/normal'

#https://www.eleganza-shop.com/designers/balenciaga?geslacht%5Bfilter%5D=Men%2C415&page=1
#https://firstbtq.com/as/brands/balenciaga?cat=3
#https://www.giuliofashion.com/collections/balenciaga/man
#corsocomo

class BalenciagaNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby balenciaga_man_n.rb
    @category = "服"
    @price = "1600"
    @currency = 
    #include + クラス名
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti
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
  "https://www.julian-fashion.com/en-IT/men/designer/balenciaga",
  "https://www.mycompanero.com/fr/brand/45-balenciaga?categories=homme",
  "https://smets.lu/collections/balenciaga/men",
  #"https://www.viettishop.com/it/designers/balenciaga?cat=462",
  
  #以下selenium
  "https://www.credomen.com/balenciaga/",
  "https://www.genteroma.com/it/designer/uomo/balenciaga.html",
  "https://shop.labelsfashion.com/men/designers/balenciaga",
  "https://www.pl-line.com/en/balenciaga",
  "https://www.papinistore.com/it/25_balenciaga"
]

    balenciaga_n_man = BalenciagaNormalMan.new
    @price = BalenciagaNormalMan.call_price
    @category = BalenciagaNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.ekseption.com/ot_en/designers/balenciaga?cat=84"
            balenciaga_n_man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.julian-fashion.com/en-IT/men/designer/balenciaga"
            balenciaga_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.mycompanero.com/fr/brand/45-balenciaga?categories=homme"
            balenciaga_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/balenciaga/men"
            balenciaga_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/balenciaga?cat=462"
            balenciaga_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.credomen.com/balenciaga/"
            balenciaga_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/balenciaga.html"
            balenciaga_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://shop.labelsfashion.com/men/designers/balenciaga"
            balenciaga_n_man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.papinistore.com/it/25_balenciaga"
            balenciaga_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.pl-line.com/en/balenciaga"
            balenciaga_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end