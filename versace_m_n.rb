require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#https://www.maltempisrl.com/product/1003701-versace-loafers-1a006931b00v/
class VersaceNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby versace_m_n.rb
    @category = "服"
    @price = "450"
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Julian, Lidia, LuisaWorld, Mycompanero, Ottodisapietro, Smets, Vietti
    include Credoman, Genteroma, Labels, Plline, Spinnaker
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    "https://www.capsulebyeso.com/en/men-versace",
    "https://grifo210.com/en/catalog/category/view/s/versace/id/364/?sale=0",
    "https://www.lidiashopping.com/en/IT/men/t/designers/versace",
    "https://www.julian-fashion.com/en-IT/men/designer/versace",
    "https://www.luisaworld.com/mens-designers/versace/",
    "https://www.mycompanero.com/fr/2-accueil?categories=homme&createurs=versace",
    "https://smets.lu/collections/versace/men",
    以下selenium
    "https://www.bernardellistores.com/it/versace",
    "https://www.credomen.com/versace/",
    "https://www.genteroma.com/it/designer/uomo/versace.html",
    # VERSACE jeansのみの取り扱いとなった "https://www.papinistore.com/en/157_versace",
    "https://www.spinnakerboutique.com/it-IT/uomo/designer/versace"
]
    versace_n_man = VersaceNormalMan.new
    @price = VersaceNormalMan.call_price
    @category = VersaceNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.capsulebyeso.com/en/men-versace"
            versace_n_man.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://grifo210.com/en/catalog/category/view/s/versace/id/364/?sale=0"
        #    versace_n_man.grifo_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/men/t/designers/versace"
            versace_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/versace"
            versace_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/mens-designers/versace/"
            versace_n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/2-accueil?categories=homme&createurs=versace"
            versace_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/versace/men"
            versace_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.bernardellistores.com/it/versace"
            versace_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        #when "https://www.credomen.com/versace/"
        #    versace_n_man.credoman_crawl_selenium(attack_site_url, @price)
        #    #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/versace.html"
            versace_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://www.papinistore.com/en/157_versace"
        #    versace_n_man.papini_crawl_selenium(attack_site_url, @price)
        #    #小数点削除必要無し jeansだけにの取扱になった
        when "https://www.spinnakerboutique.com/it-IT/uomo/designer/versace"
            versace_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end
