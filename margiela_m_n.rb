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


class MargielaNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "アクセ"
    @price = "190"
    
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
  "https://www.aldogibilaro.com/en/10000330_maison-margiela",
  "https://www.ekseption.com/ot_en/designers/maison_margiela?cat=84",
  "https://grifo210.com/en/men/designers/maison-margiela.html",
  "https://www.julin-fashion.com/en-IT/men/designer/maison_margiela",
  "https://www.mycompanero.com/fr/brand/54-maison-margiela?categories=homme",
  "https://smets.lu/collections/maison-margiela/men",
  "https://www.viettishop.com/it/designers/maison-margiela?cat=462",
  
  #以下selenium
  "https://www.bernardellistores.com/it/uomo/maison-margiela",
  "https://www.genteroma.com/it/designer/uomo/maison-margiela.html",
  "https://shop.labelsfashion.com/men/designers/maison-margiela",
  "https://www.papinistore.com/en/250_maison-margiela",
  "https://www.spinnakerboutique.com/it-IT/uomo/designer/maison_margiela"
]

margiela_n_man = MargielaNormalMan.new
@price = MargielaNormalMan.call_price
@category = MargielaNormalMan.call_category

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.aldogibilaro.com/en/10000330_maison-margiela"
        margiela_n_man.aldogibilaro_crawl(attack_site_url, @price)
        @price = @price.delete(".")   
    when "https://www.ekseption.com/ot_en/designers/maison_margiela?cat=84"
        margiela_n_man.ekseption_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://grifo210.com/en/men/designers/maison-margiela.html"
        margiela_n_man.grifo_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.julian-fashion.com/en-IT/men/designer/maison_margiela"
        margiela_n_man.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.mycompanero.com/fr/brand/54-maison-margiela?categories=homme"
        margiela_n_man.mycompanero_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://smets.lu/collections/maison-margiela/men"
        margiela_n_man.smets_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.viettishop.com/it/designers/maison-margiela?cat=462"
        margiela_n_man.vietti_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    
        #以下selenium
    when "https://www.bernardellistores.com/it/uomo/maison-margiela"
        margiela_n_man.bernardelli_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.genteroma.com/it/designer/uomo/maison-margiela.html"
        margiela_n_man.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://shop.labelsfashion.com/men/designers/maison-margiela"
        margiela_n_man.labels_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.papinistore.com/en/250_maison-margiela"
        margiela_n_man.papini_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.spinnakerboutique.com/it-IT/uomo/designer/maison_margiela"
        margiela_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    end
end

