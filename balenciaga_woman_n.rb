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


class BalenciagaNormalWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby balenciaga_woman_n.rb
    @category = "バッグ"
    @price = "1650"
    
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
    "https://www.capsulebyeso.com/en/women-balenciaga",
    "https://www.ekseption.com/ot_en/designers/balenciaga?cat=3",
    "https://www.julian-fashion.com/en-IT/women/designer/balenciaga",
    "https://www.mycompanero.com/fr/brand/45-balenciaga",
    #"https://smets.lu/collections/balenciaga/women",
    #以下selenium
    "https://www.genteroma.com/it/designer/donna/balenciaga.html",
    "https://www.ottodisanpietro.com/eu_en/woman-fashion/woman-designers/balenciaga-woman",
    "https://www.papinistore.com/it/25_balenciaga"
]

    balenciaga_n_woman = BalenciagaNormalWoman.new
    @price = BalenciagaNormalWoman.call_price
    @category = BalenciagaNormalWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.capsulebyeso.com/en/women-balenciaga"
            balenciaga_n_woman.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")  
        when "https://www.ekseption.com/ot_en/designers/balenciaga?cat=3"
            balenciaga_n_woman.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.julian-fashion.com/en-IT/women/designer/balenciaga"
            balenciaga_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.mycompanero.com/fr/brand/45-balenciaga"
            balenciaga_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/balenciaga/women"
            balenciaga_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.genteroma.com/it/designer/donna/balenciaga.html"
            balenciaga_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.ottodisanpietro.com/eu_en/woman-fashion/woman-designers/balenciaga-woman"
            balenciaga_n_woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")  
        when "https://www.papinistore.com/it/25_balenciaga" 
            balenciaga_n_woman.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end

    #https://firstbtq.com/as/women-balenciaga-hourglass-bb-monogram-wallet-with-chain-656050210de2762-8538849-os.html