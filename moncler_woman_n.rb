require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#genteromaの修正から
#✓dopeファクトリーファクトリーはオリジナルサイトをクロールすること

class MonclerNormalWoman
    #服 靴 バッグ アクセ
    #ruby moncler_woman_n.rb
    @category = "服"
    @price = "890"
    include Cortecci, Ekseption, Grifo, Julian, Lidia, LuisaWorld, Mycompanero, Smets, Vietti
    include Bernardelli, Credoman, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    #"https://www.corteccisiena.it/shop/it/brand/donna/moncler",
    "https://www.ekseption.com/ot_es/designers/moncler?cat=3",
    "https://grifo210.com/een/woman/designers/moncler.html?sale=0",
    "https://www.julian-fashion.com/it-IT/donna/designer/moncler",
    "https://www.lidiashopping.com/en/IT/women/t/designers/moncler",
    #"https://www.mycompanero.com/fr/brand/2-moncler?categories=femme",
    "https://smets.lu/collections/moncler/women",
    "https://www.viettishop.com/it/designers/moncler?cat=456",
    "https://www.luisaworld.com/product-category/woman/?product_brand=moncler",
    
    #以下selenium
    "https://www.bernardellistores.com/it/moncler",
    "https://www.genteroma.com/it/designer/donna/moncler.html",
    "https://shop.labelsfashion.com/women/designers/moncler",
    #"https://ottodisanpietro.com/collections/moncler-women",
    "https://www.pl-line.com/en/moncler", #メンズレディース一緒
    "https://www.spinnakerboutique.com/en-IT/woman/designer/moncler",
    "https://www.papinistore.com/it/58_moncler"

    #genius
    #"https://www.bernardellistores.com/it/donna/moncler-genius?order=LATEST"
    ]


    moncler_n_woman = MonclerNormalWoman.new
    @price = MonclerNormalWoman.call_price
    @category = MonclerNormalWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.corteccisiena.it/shop/it/brand/donna/moncler" 
            moncler_n_woman.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.ekseption.com/ot_es/designers/moncler?cat=3" 
            moncler_n_woman.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/een/woman/designers/moncler.html?sale=0" 
            moncler_n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/it-IT/donna/designer/moncler" 
            moncler_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/women/t/designers/moncler" 
            moncler_n_woman.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/woman/?product_brand=moncler" 
            moncler_n_woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/brand/2-moncler?categories=femme" 
            moncler_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://ottodisanpietro.com/collections/moncler-women" 
            moncler_n_woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://smets.lu/collections/moncler/women" 
            moncler_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/moncler?cat=456" 
            moncler_n_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.bernardellistores.com/it/moncler" 
            moncler_n_woman.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/donna/moncler.html"
            moncler_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://shop.labelsfashion.com/women/designers/moncler"
            moncler_n_woman.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "otto" 
            moncler_n_woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.papinistore.com/it/58_moncler" 
            moncler_n_woman.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        #when "https://www.pl-line.com/en/moncler" 
        #    moncler_n_man.plline_crawl_selenium(attack_site_url, @price)
        #    #小数点削除必要無し
        when "https://www.spinnakerboutique.com/en-IT/woman/designer/moncler"    
            moncler_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        end
    end


#https://www.wakakuu.com/en/designers/moncler?products=98