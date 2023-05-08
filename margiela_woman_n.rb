require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#"https://shop.wendelavandijk.com/brands/maison-margiela/"
#https://www.berneboutique.com/brand/10-maison-margiela
#pozzileiまで完了
class MargielaNormalWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby margiela_woman_n.rb
    @category = "バッグ"
    @price = "1550"
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Julian, Lidia, LuisaWorld, Mycompanero, Smets, Vietti
    include Bernardelli, Corsocomo, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Pozzilei, Spinnaker, WrongWeather
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    #"https://www.aldogibilaro.com/en/10000330_maison-margiela",
    #"https://www.ekseption.com/ot_en/designers/maison_margiela?cat=3",
    #"https://grifo210.com/it/donna/designers/maison-margiela.html",
    #"https://www.julian-fashion.com/en-IT/women/designer/maison_margiela",
    #"https://www.mycompanero.com/fr/brand/54-maison-margiela?categories=femme",
    #"https://smets.lu/collections/maison-margiela/women",

    #以下selenium
    #"https://10corsocomo.com/collections/maison-margiela?filter.p.m.elastick.gender=Woman"
    #"https://www.genteroma.com/it/designer/donna/maison-margiela.html",
    #"https://labelsfashion.com/collections/women-maison-margiela",
    #"https://www.papinistore.com/en/250_maison-margiela",
    "https://www.pozzilei.it/en/maison-margiela"
    #"https://www.spinnakerboutique.com/it-IT/donna/designer/maison_margiela",
    #"https://www.viettishop.com/en/women/designers/maison-margiela"
]
    margiela_n_woman = MargielaNormalWoman.new
    @category = MargielaNormalWoman.call_category
    @price = MargielaNormalWoman.call_price

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.aldogibilaro.com/en/10000330_maison-margiela"
            margiela_n_woman.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")    
        when "https://www.ekseption.com/ot_en/designers/maison_margiela?cat=3"
            margiela_n_woman.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/it/donna/designers/maison-margiela.html"
            margiela_n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/women/designer/maison_margiela"
            margiela_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.mycompanero.com/fr/brand/54-maison-margiela?categories=femme"
            margiela_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/maison-margiela/women"
            margiela_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://10corsocomo.com/collections/maison-margiela?filter.p.m.elastick.gender=Woman"
            margiela_n_woman.corsocomo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.genteroma.com/it/designer/donna/maison-margiela.html"
            margiela_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://labelsfashion.com/collections/women-maison-margiela"
            margiela_n_woman.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.papinistore.com/en/250_maison-margiela"
            margiela_n_woman.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.com/it-IT/donna/designer/maison_margiela"
            margiela_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.pozzilei.it/en/maison-margiela"
            margiela_n_woman.pozzilei_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.viettishop.com/en/women/designers/maison-margiela"
            margiela_n_woman.vietti_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end
