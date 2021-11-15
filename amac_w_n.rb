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


class AmacNormalWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "920"
    
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
  "https://www.capsulebyeso.com/en/men-alexander+mcqueen",
  "https://grifo210.com/en/catalog/category/view/s/alexander-mcqueen/id/361/",
  "https://www.julian-fashion.com/en-IT/women/designer/alexander_mcqueen",
  "https://www.luisaworld.com/product-category/woman/?product_brand=alexander-mcqueen",
  "https://www.mycompanero.com/fr/brand/33-alexander-mcqueen?categories=femme",
  "https://smets.lu/collections/alexander-mcqueen/women",
  "https://www.viettishop.com/it/designers/alexander-mcqueen?cat=456",
    
  #以下selenium
  "https://www.genteroma.com/it/designer/donna/alexander-mcqueen.html",
  "https://www.spinnakerboutique.com/it-IT/donna/designer/alexander_mcqueen"
]

    amac_n_woman = AmacNormalWoman.new
    @price = AmacNormalWoman.call_price
    @category = AmacNormalWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url        
        when "https://www.capsulebyeso.com/en/men-alexander+mcqueen"
            amac_n_woman.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")  
        when "https://grifo210.com/en/catalog/category/view/s/alexander-mcqueen/id/361/"
            amac_n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.julian-fashion.com/en-IT/women/designer/alexander_mcqueen"
            amac_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/woman/?product_brand=alexander-mcqueen"
            amac_n_woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/brand/33-alexander-mcqueen?categories=femme"
            amac_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/alexander-mcqueen/women"
            amac_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/alexander-mcqueen?cat=456"
            amac_n_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.genteroma.com/it/designer/donna/alexander-mcqueen.html"
            amac_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.spinnakerboutique.com/it-IT/donna/designer/alexander_mcqueen"
            amac_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        end
    end