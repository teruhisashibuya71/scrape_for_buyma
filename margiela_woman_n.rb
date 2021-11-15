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


"https://shop.wendelavandijk.com/brands/maison-margiela/"

class OOOONormalWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "880"
    
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
    "https://www.aldogibilaro.com/en/10000330_maison-margiela",
    "https://www.ekseption.com/ot_en/designers/maison_margiela?cat=3",
    "https://grifo210.com/en/woman/designers/maison-margiela.html?sale=0",
    "https://www.julian-fashion.com/en-IT/women/designer/maison_margiela",
    "https://www.mycompanero.com/fr/brand/54-maison-margiela?categories=femme",
    "https://smets.lu/collections/maison-margiela/women",
    "https://www.viettishop.com/it/designers/maison-margiela?cat=456",

    #以下selenium
    "https://www.genteroma.com/it/designer/donna/maison-margiela.html",
    "https://shop.labelsfashion.com/women/designers/maison-margiela",
    #"otto",
    "https://www.papinistore.com/en/250_maison-margiela",
    "https://www.spinnakerboutique.it/en/women#/manFilters=412&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
]

    moncler_n_woman = MonclerNormalWoman.new
    @price = MonclerNormalWoman.call_price
    @category = MonclerNormalWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.aldogibilaro.com/en/10000330_maison-margiela"
            moncler_n_woman.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")    
        when "https://www.ekseption.com/ot_en/designers/maison_margiela?cat=3"
            moncler_n_woman.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/en/woman/designers/maison-margiela.html?sale=0"
            moncler_n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.julian-fashion.com/en-IT/women/designer/maison_margiela"
            moncler_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.mycompanero.com/fr/brand/54-maison-margiela?categories=femme"
            moncler_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/maison-margiela/women",
            moncler_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/maison-margiela?cat=456",
            moncler_n_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.genteroma.com/it/designer/donna/maison-margiela.html"
            moncler_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://shop.labelsfashion.com/women/designers/maison-margiela"
            moncler_n_woman.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        #when "otto"
        #    moncler_n_woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(",")
        when "https://www.papinistore.com/en/250_maison-margiela"
            moncler_n_woman.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.it/en/women#/manFilters=412&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
            moncler_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        end
    end
