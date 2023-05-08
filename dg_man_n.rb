require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

class DgNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby dg_man_n.rb
    @category = "バッグ"
    @price = "1650"
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Julian, Lidia, LuisaWorld, Mycompanero, Smets, Vietti
    include Bernardelli, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    #"https://www.aldogibilaro.com/en/10000085_dolce-gabbana",
    #"https://www.corteccisiena.it/shop/it/brand/uomo/dolce%20&%20gabbana",
    #"https://www.lidiashopping.com/en/IT/men/t/designers/dolce-and-gabbana",
    #"https://www.julian-fashion.com/en-IT/men/designer/dolce_and_gabbana",
    ##"https://www.viettishop.com/it/designers/dolce-gabbana?cat=462",
    #
    ##以下selenium
    #"https://www.credomen.com/dolcegabbana/",
    #"https://www.genteroma.com/it/designer/uomo/dolce-gabbana.html",
    "https://grifo210.com/iit/uomo/designers/dolce-gabbana.html",
    #"https://www.spinnakerboutique.com/it-IT/uomo/designer/dolce___gabbana",
    #"https://www.dante5.com/en-IT/men/designer/dolce__gabbana"
]

    dg_n_man = DgNormalMan.new
    @price = DgNormalMan.call_price
    @category = DgNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.aldogibilaro.com/en/10000085_dolce-gabbana"
            dg_n_man.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")   
        when "https://www.corteccisiena.it/shop/it/brand/uomo/dolce%20&%20gabbana"
            dg_n_man.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/men/t/designers/dolce-and-gabbana"
            dg_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/dolce_and_gabbana"
            dg_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/dolce-gabbana?cat=462"
            dg_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.credomen.com/dolcegabbana/"
            dg_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.dante5.com/en-IT/men/designer/dolce__gabbana"
            dg_n_man.dante5_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.genteroma.com/it/designer/uomo/dolce-gabbana.html"
            dg_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://grifo210.com/iit/uomo/designers/dolce-gabbana.html"
            dg_n_man.grifo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.spinnakerboutique.com/it-IT/uomo/designer/dolce___gabbana"
            dg_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end