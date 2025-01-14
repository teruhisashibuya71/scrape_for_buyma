require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

class LoeweNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby loewe_man_n.rb
    @category = "服"
    @price = "3900"
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Julian #0サイズあるよ, Lidia, LuisaWorld, Mycompanero, Smets, Vietti
    include Bernardelli, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
  "https://www.ekseption.com/collections/loewe?sort_by=manual&filter.p.m.custom.departamento=Hombre",
  "https://www.lidiashopping.com/en/IT/men/t/designers/loewe",
  "https://www.julian-fashion.com/en-IT/men/designer/loewe",
  "https://www.luisaworld.com/product-category/man/?product_brand=loewe",
  "https://smets.lu/collections/loewe-men",
  "https://www.viettishop.com/it/designers/loewe?cat=462",
  
  #以下selenium
  "https://www.genteroma.com/it/designer/uomo/loewe.html",
  # "https://ottodisanpietro.com/collections/loewe-men"
  "https://www.papinistore.com/en/60_loewe"

  #イビザ系
  #https://www.luisaworld.com/product-category/man/?product_brand=loewe-paulas-ibiza
  #"https://www.graphiti.fr/9_loewe/s-9/public-homme"
]

    _n_man = NormalMan.new
    @price = NormalMan.call_price
    @category = NormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.ekseption.com/ot_en/designers/loewe"
            _n_man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.lidiashopping.com/en/IT/men/t/designers/loewe"
            _n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/loewe"
            _n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/man/?product_brand=loewe"
            _n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/loewe/men"
            _n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/loewe?cat=462"
            _n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #以下selenium
        when "https://www.genteroma.com/it/designer/uomo/loewe.html"
            _n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.papinistore.com/en/60_loewe"
            _n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end


