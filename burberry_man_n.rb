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


#nida
class BurberryNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby burberry_man_n.rb
    @category = "バッグ"
    @price = "580"
    
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
  "https://www.ekseption.com/ot_en/designers/burberry?cat=84",
  "https://grifo210.com/een/men/designers/burberry.html?sale=0",
  "https://www.lidiashopping.com/en/IT/men/t/designers/burberry", #BD
  "https://www.julian-fashion.com/en-IT/men/designer/burberry",
  "https://www.mycompanero.com/fr/brand/34-burberry?categories=homme",
  #"https://smets.lu/collections/burberry/men",
  #"https://www.viettishop.com/it/designers/burberry?cat=462",
  
  #以下selenium
  "https://www.credomen.com/burberry/",
  "https://www.genteroma.com/it/designer/uomo/burberry.html",
  "https://shop.labelsfashion.com/men/designers/burberry",
  "https://www.pl-line.com/en/burberry",
  "https://www.spinnakerboutique.com/en-IT/man/designer/burberry",
  "https://www.papinistore.com/it/30_burberry",
  "https://ottodisanpietro.com/collections/burberry-men",
]

    burberry_n_man = BurberryNormalMan.new
    @price = BurberryNormalMan.call_price
    @category = BurberryNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.ekseption.com/ot_en/designers/burberry?cat=84" 
            burberry_n_man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/een/men/designers/burberry.html?sale=0"
            burberry_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/men/t/designers/burberry"
            burberry_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/burberry"
            burberry_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.mycompanero.com/fr/brand/34-burberry?categories=homme"
            burberry_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/burberry/men"
            burberry_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/burberry?cat=462"
            burberry_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.credomen.com/burberry/"
            burberry_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/burberry.html"
            burberry_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://shop.labelsfashion.com/men/designers/burberry"
            burberry_n_man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://ottodisanpietro.com/collections/burberry-men"
            burberry_n_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.papinistore.com/it/30_burberry"
            burberry_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.pl-line.com/en/burberry"
            burberry_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.com/en-IT/man/designer/burberry"
            burberry_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end



