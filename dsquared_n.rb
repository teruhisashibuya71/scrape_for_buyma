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
require './credoman'
require './labels'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'


class Dsquard2NormalMan

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
    "https://www.aldogibilaro.com/en/10000227_dsquared2",
    "https://grifo210.com/en/catalog/category/view/s/dsquared2/id/490/",
    "https://www.lidiashopping.com/en/IT/men/t/designers/dsquared2",
    "https://www.julian-fashion.com/en-IT/men/designer/dsquared2",
    "https://www.mycompanero.com/fr/brand/20-dsquared2",
    "https://smets.lu/collections/dsquared2/men",
    
    #以下selenium
    "https://www.bernardellistores.com/it/dsquared2",
    "https://www.credomen.com/dsquared2/",
    "https://www.credomen.com/dsquared2icon/",
    "https://www.genteroma.com/it/designer/uomo/dsquared2.html",
    "https://www.papinistore.com/en/46_dsquared",
    "https://www.pl-line.com/en/dsquared2",
]

    moncler_n_man = MonclerNormalMan.new
    @price = MonclerNormalMan.call_price
    @category = MonclerNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.aldogibilaro.com/en/10000227_dsquared2"
            moncler_n_man.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")   
        when "https://grifo210.com/en/catalog/category/view/s/dsquared2/id/490/"
            moncler_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/men/t/designers/dsquared2"
            moncler_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/dsquared2"
            moncler_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.mycompanero.com/fr/brand/20-dsquared2"
            moncler_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/dsquared2/men"
            moncler_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.bernardellistores.com/it/dsquared2"
            moncler_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.credomen.com/dsquared2/"
            moncler_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.credomen.com/dsquared2/"
            moncler_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        #icon
        when "https://www.credomen.com/dsquared2icon/"
            moncler_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/dsquared2.html"
            moncler_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.papinistore.com/en/46_dsquared"
            moncler_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.pl-line.com/en/dsquared2"
            moncler_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end