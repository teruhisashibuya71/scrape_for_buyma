require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#papini vietti OK
class SlNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby slaurent_man_n.rb
    @category = "バッグ"
    @price = "1100"
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    "https://grifo210.com/en/men/designers/saint-laurent.html?sale=0",
    "https://www.julian-fashion.com/en-IT/men/designer/saint_laurent",
    "https://www.luisaworld.com/product-category/man/?product_brand=saint-laurent",
    "https://www.mycompanero.com/fr/brand/4-saint-laurent?categories=homme",
    "https://smets.lu/collections/saint-laurent/men",

    #以下selenium
    "https://www.credomen.com/saintlaurent/",
    "https://www.dante5.com/it-IT/uomo/designer/saint_laurent",
    "https://www.genteroma.com/it/designer/uomo/saint-laurent.html",
    "https://www.spinnakerboutique.com/it-IT/uomo/designer/saint_laurent",
    "https://www.papinistore.com/uomo-brand-saint-laurent",
    "https://www.viettishop.com/it/uomo/designers/saint-laurent"
    #"https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/saint-laurent-man"
]
    sl_normal_man = SlNormalMan.new
    @price = SlNormalMan.call_price
    @category = SlNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://grifo210.com/en/men/designers/saint-laurent.html?sale=0"
            sl_normal_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/saint_laurent"
            sl_normal_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/man/?product_brand=saint-laurent"
            sl_normal_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/brand/4-saint-laurent?categories=homme"
            sl_normal_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/saint-laurent/men"
            sl_normal_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.credomen.com/saintlaurent/"
            sl_normal_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.dante5.com/it-IT/uomo/designer/saint_laurent"
            sl_normal_man.dante5_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.genteroma.com/it/designer/uomo/saint-laurent.html"
            sl_normal_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/saint-laurent-man"
            sl_normal_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.papinistore.com/en/33_saint-laurent"
            sl_normal_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.com/it-IT/uomo/designer/saint_laurent"
            sl_normal_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.viettishop.com/it/designers/saint-laurent?cat=462"
            sl_normal_man.vietti_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end



    #https://www.fouramsterdam.com/brands/saint-laurent/
    #https://www.maltempisrl.com/it/shop-italiano/?brand=saint-laurent
    #https://giomoretti.com/it/products/uomo-saint-laurent-bianco-6729060-4091410
#https://www.chenzo.it/en/product/saint-laurent-en-67290600nd0-9017
https://plazafashionstore.com/brand/saint-laurent