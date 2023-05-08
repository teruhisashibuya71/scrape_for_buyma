require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

class MonclerNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby moncler_man_n.rb
    @@category = "バッグ"
    @price = "535"
    
    #nokogiri #seleniumで行分け
    include Cortecci, Ekseption, Grifo, Julian, Lidia, LuisaWorld, Mycompanero, Smets, Vietti
    include Bernardelli, Credoman, Genteroma, Labels, Ottodisapietro, Plline, Spinnaker
    #Papini,
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    "https://www.corteccisiena.it/shop/it/brand/uomo/moncler",
    "https://www.ekseption.com/ot_en/designers/moncler?cat=84",
    "https://grifo210.com/een/catalog/category/view/s/moncler/id/389/?sale=0",
    "https://www.lidiashopping.com/en/IT/men/t/designers/moncler",
    "https://www.mycompanero.com/fr/brand/2-moncler?categories=homme",
    "https://smets.lu/collections/moncler/men",
    "https://www.julian-fashion.com/it-IT/uomo/designer/moncler",
    "https://www.viettishop.com/it/designers/moncler?cat=462",
    "https://www.luisaworld.com/product-category/man/?product_brand=moncler",
    #以下selenium
    "https://www.bernardellistores.com/it/uomo/moncler",
    "https://www.credomen.com/moncler/",
    "https://www.genteroma.com/it/designer/uomo/moncler.html",
    "https://shop.labelsfashion.com/men/designers/moncler",
    #"https://ottodisanpietro.com/collections/moncler-men",
    "https://www.pl-line.com/en/moncler?gender=men",
    "https://www.spinnakerboutique.com/it-IT/uomo/designer/moncler",
    "https://www.papinistore.com/it/633-uomo#s-4/uomo-nuovi_arrivi/designers-moncler"

    #ジーニアス
    #"https://www.bernardellistores.com/it/moncler-genius",

    #フラグメント
    #"https://www.bernardellistores.com/it/moncler-fragment"

    #グルノーブル
    #"https://ottodisanpietro.com/collections/moncler-grenoble-men"
]

    moncler_n_man = MonclerNormalMan.new
    @price = MonclerNormalMan.call_price
    @category = MonclerNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.corteccisiena.it/shop/it/brand/uomo/moncler"
            moncler_n_man.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.ekseption.com/ot_en/designers/moncler?cat=84"
            moncler_n_man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/een/catalog/category/view/s/moncler/id/389/?sale=0"
            moncler_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/it-IT/uomo/designer/moncler"
            moncler_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")    
        when "https://www.lidiashopping.com/en/IT/men/t/designers/moncler"
            moncler_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/man/?product_brand=moncler"
            moncler_n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/brand/2-moncler?categories=homme"
            moncler_n_man.mycompanero_crawl(attack_site_url, @price)
            #調整なし 4桁価格の場合は ngsp; のため
        when "https://smets.lu/collections/moncler/men"
            moncler_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/moncler"
            moncler_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

            #以下selenium
        when "https://www.bernardellistores.com/it/uomo/moncler" 
            moncler_n_man.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し    
        when "https://www.credomen.com/moncler/" 
            moncler_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/moncler.html" 
            moncler_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://shop.labelsfashion.com/men/designers/moncler" 
            moncler_n_man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        #when "https://ottodisanpietro.com/collections/moncler-men" 
        #    moncler_n_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(",")
        when "https://papinistore.com/it/633-uomo#s-4/uomo-nuovi_arrivi/designers-moncler" 
            moncler_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.com/it-IT/uomo/designer/moncler"    
            moncler_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.pl-line.com/en/moncler?gender=men" 
            moncler_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end


#brother2
#https://www.mientus.com/en/moncler-down-jacket-vabb-11673?c=3
#https://www.circle-fashion.com/clothing-c1/coats-jackets-c6/wimereux-navy-shell-jacket-p46928
#https://www.10corsocomo-theshoponline.com/ita_en/brand/moncler-genius-man