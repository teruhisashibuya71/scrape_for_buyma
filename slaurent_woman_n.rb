require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#https://www.papinistore.com/home

class SlNormalWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby slaurent_woman_n.rb
    @category = "靴"
    @price = "625"
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
    "https://www.ekseption.com/ot_en/designers/saint_laurent",
    "https://grifo210.com/en/woman/designers/saint-laurent.html?sale=0",
    "https://www.ilduomo.it/designer/saint-laurent.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc",
    "https://www.julian-fashion.com/en-IT/women/designer/saint_laurent",
    "https://www.luisaworld.com/product-category/woman/?product_brand=saint-laurent",
    "https://www.mycompanero.com/fr/brand/4-saint-laurent?categories=femme",
    #"https://smets.lu/collections/saint-laurent/women",
    #"https://www.viettishop.com/it/designers/saint-laurent?cat=456",

    #以下selenium
    "https://www.genteroma.com/it/designer/donna/saint-laurent.html",
    "https://ottodisanpietro.com/collections/saint-laurent-women?page=2",
    "https://www.pl-line.com/en/saint-laurent",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/saint_laurent",
    "https://www.papinistore.com/en/33_saint-laurent"
]

    sl_n_woman = SlNormalWoman.new
    @price = SlNormalWoman.call_price
    @category = SlNormalWoman.call_category
    @ccurrency = SlNormalWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.ekseption.com/ot_en/designers/saint_laurent"
            sl_n_woman.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/en/woman/designers/saint-laurent.html?sale=0"
            sl_n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/women/designer/saint_laurent"
            sl_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/woman/?product_brand=saint-laurent"
            sl_n_woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.ilduomo.it/designer/saint-laurent.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc"
            sl_n_woman.ilduomo_crawl(attack_site_url, @price, @currnecy)
            #日本円調整のため小数点調整 無し
        when "https://www.mycompanero.com/fr/brand/4-saint-laurent?categories=femme"
            sl_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/saint-laurent/women"
            sl_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/saint-laurent?cat=456"
            sl_n_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.genteroma.com/it/designer/donna/saint-laurent.html"
            sl_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://ottodisanpietro.com/collections/saint-laurent-women?page=2"
            sl_n_woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.papinistore.com/en/33_saint-laurent" 
            sl_n_woman.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.pl-line.com/en/saint-laurent"
            sl_n_woman.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.com/it-IT/donna/designer/saint_laurent"
            sl_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 

            
        end
    end
