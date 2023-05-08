require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#https://www.santaeulalia.com/ru/sale.html?se_sap_brand=1450
#https://www.mariodannashop.it/it/uomo/designer/dsquared/gruppi?s=4

class Dsquard2NormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby dsquared_man_n.rb
    @category = "靴"
    @price = "495"
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    #"https://www.aldogibilaro.com/en/10000227_dsquared2",
    "https://grifo210.com/en/catalog/category/view/s/dsquared2/id/490/",
    "https://www.lidiashopping.com/en/IT/men/t/designers/dsquared2",
    "https://www.julian-fashion.com/en-IT/men/designer/dsquared2",
    "https://www.mycompanero.com/fr/brand/20-dsquared2",
    "https://smets.lu/collections/dsquared2/men",
    
    #以下selenium
    "https://www.bernardellistores.com/it/dsquared2",
    "https://www.credomen.com/dsquared2/",
    "https://www.credomen.com/dsquared2icon/",
    "https://www.genteroma.com/it/designer/uomo/dsquared2.html",
    "https://www.pl-line.com/en/dsquared2",
    "https://www.papinistore.com/en/46_dsquared"
]

    dsq_n_man = Dsquard2NormalMan.new
    @price = Dsquard2NormalMan.call_price
    @category = Dsquard2NormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.aldogibilaro.com/en/10000227_dsquared2"
            dsq_n_man.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")   
        when "https://grifo210.com/en/catalog/category/view/s/dsquared2/id/490/"
            dsq_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/men/t/designers/dsquared2"
            dsq_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/dsquared2"
            dsq_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.mycompanero.com/fr/brand/20-dsquared2"
            dsq_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/dsquared2/men"
            dsq_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.bernardellistores.com/it/dsquared2"
            dsq_n_man.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.credomen.com/dsquared2/"
            dsq_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        #when "https://www.credomen.com/dsquared2icon/"
        #    dsq_n_man.credoman_crawl_selenium(attack_site_url, @price)
        #    #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/dsquared2.html"
            dsq_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.papinistore.com/en/46_dsquared"
            dsq_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.pl-line.com/en/dsquared2"
            dsq_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end



    #https://shop.vandaboutique.com/en/80_dsquared2?c=203
    #https://www.r-shop.gr/en/dsquared