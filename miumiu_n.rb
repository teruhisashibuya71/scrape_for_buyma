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
require './dante5'
require './labels'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'


#https://www.galianostore.com/en_eu/women/miu_miu.html

class MiuNormalWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby miumiu_n.rb
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
    "https://www.julian-fashion.com/en-IT/women/designer/miu_miu",
    #"https://www.mycompanero.com/fr/brand/44-miu-miu",
    "https://smets.lu/collections/miu-miu/women",
    "https://www.viettishop.com/it/designers/miu-miu",
    #以下selenium
    "https://www.spinnakerboutique.com/it-IT/donna/designer/miu_miu"
]

    miu_n_woman = MiuNormalWoman.new
    @price = MiuNormalWoman.call_price
    @category = MiuNormalWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.julian-fashion.com/en-IT/women/designer/miu_miu"
            miu_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.mycompanero.com/fr/brand/44-miu-miu"
            miu_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/miu-miu/women"
            miu_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/miu-miu"
            miu_n_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.spinnakerboutique.com/it-IT/donna/designer/miu_miu"
            miu_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        end
    end





