require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#ilduomoまで改修済み 1/15
class VersaceNormalWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby versace_w_n.rb
    @category = "バッグ"
    @price = "1200"
    @currency = 147.1
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
    def self.call_currency
        @currency
    end
end

ATTACK_LIST_URL = [
    #nokogiri系
    "https://www.capsulebyeso.com/en/women-versace",
    "https://grifo210.com/it/catalog/category/view/s/versace/id/363/?sale=0",
    "https://www.ilduomo.it/designer/versace.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc",
    "https://www.lidiashopping.com/en/IT/women/t/designers/versace",
    "https://www.julian-fashion.com/en-IT/women/designer/versace",
    "https://www.luisaworld.com/woman/designers/versace/",
    "https://www.mycompanero.com/fr/brand/53-versace?categories=femme",
    "https://smets.lu/collections/versace",

    #selenium
    #"https://www.bernardellistores.com/it/versace",
    "https://www.dante5.com/it-IT/donna/designer/versace",
    "https://www.genteroma.com/it/designer/donna/versace.html",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/versace"

]

    versace_n_woman = VersaceNormalWoman.new
    @price = VersaceNormalWoman.call_price
    @category = VersaceNormalWoman.call_category
    @currency = VersaceNormalWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.capsulebyeso.com/en/women-versace"
            versace_n_woman.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")  
        when "https://grifo210.com/it/catalog/category/view/s/versace/id/363/?sale=0"
            versace_n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.ilduomo.it/designer/versace.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc"
            versace_n_woman.ilduomo_crawl(attack_site_url, @price, @currency)
            #日本円調整のため小数点調整 無し
        when "https://www.julian-fashion.com/en-IT/women/designer/versace"
            versace_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/women/t/designers/versace"
            versace_n_woman.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/woman/designers/versace/"
            versace_n_woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/brand/53-versace?categories=femme"
            versace_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/versace"
            versace_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.bernardellistores.com/it/versace"
            versace_n_woman.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点調整なし
        when "https://www.dante5.com/it-IT/donna/designer/versace"
            versace_n_woman.dante5_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.genteroma.com/it/designer/donna/versace.html"
            versace_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.spinnakerboutique.com/it-IT/donna/designer/versace"
            versace_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
    end
end