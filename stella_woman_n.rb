require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'


class StellaNormalWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby stella_woman_n.rb
    @category = "バッグ"
    @price = "750"
    @currency = 149.9
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Corsocomo, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti
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
    "https://www.julian-fashion.com/en-IT/women/designer/stella_mccartney",
    "https://www.luisaworld.com/product-category/woman/?product_brand=stella-mccartney",
    #以下selenium
    "https://10corsocomo.com/en-jp/collections/stella-mccartney?filter.p.m.elastick.gender=Woman",  
    "https://www.dante5.com/it-IT/donna/designer/stella_mc_cartney",
    "https://www.genteroma.com/it/designer/donna/stella-mccartney.html",
    "https://grifo210.com/en/catalog/category/view/s/stella-mccartney/id/422/",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/stella_mccartney",
    "https://www.papinistore.com/donna-brand-stella-mccartney"
]

stella_n_woman = StellaNormalWoman.new
@price = StellaNormalWoman.call_price
@category = StellaNormalWoman.call_category
@currency = StellaNormalWoman.call_currency

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.julian-fashion.com/en-IT/women/designer/stella_mccartney"
        stella_n_woman.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.luisaworld.com/product-category/woman/?product_brand=stella-mccartney"
        stella_n_woman.luisa_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    
    #以下selenium
    when "https://10corsocomo.com/en-jp/collections/stella-mccartney?filter.p.m.elastick.gender=Woman"
        stella_n_woman.corsocomo_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")      
    when "https://www.dante5.com/it-IT/donna/designer/stella_mc_cartney"
        stella_n_woman.dante5_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.genteroma.com/it/designer/donna/stella-mccartney.html"
        stella_n_woman.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://grifo210.com/en/catalog/category/view/s/stella-mccartney/id/422/"
        stella_n_woman.grifo_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
      when "https://www.papinistore.com/donna-brand-stella-mccartney"
        stella_n_woman.papini_crawl_selenium(attack_site_url, @price, @currency)
        #小数点削除必要無し
    when "https://www.spinnakerboutique.com/it-IT/donna/designer/stella_mccartney"
        stella_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し 
    end
end