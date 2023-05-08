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
require './smets'
require './vietti'

#以下selenium
require './bernardelli'
require './credoman'
require './dante5'
require './labels'
require './ottodisapietro'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'


class GivenchyNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby givency_man_n.rb
    @category = "服"
    @price = "495"
    
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
    include Smets
    include Vietti
    
    #selenium
    include Bernardelli
    include Credoman
    include Dante5
    include Genteroma
    include Labels
    include Ottodisapietro
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
    "https://www.capsulebyeso.com/en/men-givenchy",
    "https://www.ekseption.com/ot_en/designers/givenchy",
    "https://grifo210.com/en/men/designers/givenchy.html?sale=0",
    "https://www.lidiashopping.com/en/IT/men/t/designers/givenchy",
    "https://www.julian-fashion.com/en-IT/men/designer/givenchy",
    "https://www.luisaworld.com/product-category/man/?product_brand=givenchy",
    "https://smets.lu/collections/givenchy/men",
    #"https://www.viettishop.com/it/designers/givenchy?cat=462",
    #以下selenium
    "https://www.credomen.com/givenchy/",
    "https://www.genteroma.com/it/designer/uomo/givenchy.html",
    "https://shop.labelsfashion.com/men/designers/givenchy",
    "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/givenchy-man",
    "https://www.papinistore.com/en/21_givenchy",
    "https://www.pl-line.com/en/givenchy",
    "https://www.spinnakerboutique.com/it-IT/uomo/designer/givenchy"
]

    givency_n_man = GivenchyNormalMan.new
    @price = GivenchyNormalMan.call_price
    @category = GivenchyNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.capsulebyeso.com/en/men-givenchy"
            givency_n_man.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.ekseption.com/ot_en/designers/givenchy"
            givency_n_man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/en/men/designers/givenchy.html?sale=0"
            givency_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/men/t/designers/givenchy"
            givency_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/givenchy"
            givency_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/man/?product_brand=givenchy"
            givency_n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/givenchy/men"
            givency_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/givenchy?cat=462"
            givency_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.credomen.com/givenchy/"
            givency_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/givenchy.html"
            givency_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://shop.labelsfashion.com/men/designers/givenchy"
            givency_n_man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/givenchy-man"
            givency_n_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.papinistore.com/en/21_givenchy"
            givency_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.pl-line.com/en/givenchy"
            givency_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.com/it-IT/uomo/designer/givenchy"
            givency_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end


    #https://www.dapperliverpool.com/index.php?route=product/manufacturer/info&manufacturer_id=32
    #https://www.hionidis.com/designers/givenchy