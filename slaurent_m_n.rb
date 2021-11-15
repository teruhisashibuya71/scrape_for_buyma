require 'rubygems'
require 'nokogiri'
require 'open-uri'

#./'ファイル名'
require './aldogibilaro'
require './capsel'
require './cortecci'
require './ekseption'
require './grifo'
require './julian'
require './lidia'
require './luisa_world'
require './mycompanero'
require './ottodisapietro'
require './smets'
require './vietti'

#以下selenium
require './bernardelli'
require './credoman'
require './labels'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'


class SlNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "800"
    
    #include + クラス名
    include Aldogibilaro
    include Capsel
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
    include Bernardelli
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
    "https://grifo210.com/en/men/designers/saint-laurent.html?sale=0",
    "https://www.julian-fashion.com/en-IT/men/designer/saint_laurent",
    "https://www.luisaworld.com/product-category/man/?product_brand=saint-laurent",
    "https://www.mycompanero.com/fr/brand/4-saint-laurent?categories=homme",
    "https://smets.lu/collections/saint-laurent/men",
    "https://www.viettishop.com/it/designers/saint-laurent?cat=462",

    #以下selenium
    "https://www.credomen.com/saintlaurent/",
    "https://www.genteroma.com/it/designer/uomo/saint-laurent.html",
    "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/saint-laurent-man",
    "https://www.papinistore.com/en/33_saint-laurent",
    "https://www.spinnakerboutique.com/it-IT/uomo/designer/saint_laurent"
]

    sl_normal_man = SlNormalMan.new
    @price = SlNormalMan.call_price
    @category = SlNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "aldogibilallo"
            sl_normal_man.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")   
        when "capsel"
            sl_normal_man.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "cortecci"
            sl_normal_man.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "ekseption"
            sl_normal_man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "grifo"
            sl_normal_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "lidia"
            sl_normal_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "julian"
            sl_normal_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "luisaworld"
            sl_normal_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "mycompanero"
            sl_normal_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "smets"
            sl_normal_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "vietti"
            sl_normal_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "bernaldi"
            sl_normal_man.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "credoman"
            sl_normal_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "gente"
            sl_normal_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "labels"
            sl_normal_man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "otto"
            sl_normal_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "papini"
            sl_normal_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "pl"
            sl_normal_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "spin"
            sl_normal_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end


#nokogiri
https://www.aldogibilaro.com/en/brands
https://www.capsulebyeso.com/en/brand.html
https://www.corteccisiena.it/shop/home
https://www.ekseption.com/ot_es/designers?___store=ot_es&___from_store=ot_en
https://grifo210.com/iit/
https://www.lidiashopping.com/en/IT/men/designers
https://www.julian-fashion.com/en-IT/men/designers
https://www.luisaworld.com/mens-designers/
https://www.mycompanero.com/fr/
https://smets.lu/pages/brands-men
https://www.viettishop.com/it/designers/



#selenium
https://www.bernardellistores.com/it/brands#men
https://www.credomen.com/
https://www.genteroma.com/it/designers/gender/male/
https://shop.labelsfashion.com/men/designers
https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers
https://www.papinistore.com/designers
https://www.pl-line.com/en/brands
https://www.spinnakerboutique.com/it-IT/uomo/designers
