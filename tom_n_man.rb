require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#ilduomoまで改修済み 1/15
class TomNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby tom_n_man.rb
    @category = "服"
    @price = "2390"
    @currency = 143.2
    #include + クラス名
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
    #"https://bungalow.store/de/men/designer/tom-ford/?p=1"
    "https://www.julian-fashion.com/en-IT/men/designer/tom_ford",
    "https://www.ilduomo.it/designer/tom-ford.html?gender=man&resultsPerPage=2000&order=product.date_add.desc",
    #"https://www.susi.it/en-GB/man/f/tom-ford/"
    #以下selenium
    "https://www.bernardellistores.com/it/tom-ford",
    "https://www.credomen.com/tomford/",
    "https://www.genteroma.com/it/designer/uomo/tom-ford.html",
    "https://labelsfashion.com/en-jp/collections/men-tom-ford",
    "https://www.pl-line.com/en/tom-ford"
    #"https://viettishop.com/collections/tom-ford/men"
    #"https://www.graphiti.fr/brand/32-tom-ford"
]

tom_n_man = TomNormalMan.new
@price = TomNormalMan.call_price
@category = TomNormalMan.call_category
@currency = TomNormalMan.call_currency

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.ilduomo.it/designer/tom-ford.html?gender=man&resultsPerPage=2000&order=product.date_add.desc"
        tom_n_man.ilduomo_crawl(attack_site_url, @price, @currency)
        #日本円調整のため小数点調整 無し
    when "https://www.julian-fashion.com/en-IT/men/designer/tom_ford"
        tom_n_man.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.viettishop.com/eshop/category/VIETTI-Tom-Ford.html/1/frmCatID/104653/"
        tom_n_man.vietti_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    #以下selenium
    when "https://www.bernardellistores.com/it/tom-ford"
        tom_n_man.bernardelli_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.credomen.com/tomford/"
        tom_n_man.credoman_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.genteroma.com/it/designer/uomo/tom-ford.html"
        tom_n_man.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://labelsfashion.com/en-jp/collections/men-tom-ford"
        tom_n_man.labels_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.pl-line.com/en/tom-ford"
        tom_n_man.plline_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    end
end

#fourAMster
#https://www.circle-fashion.com/tom-ford-m348#page2
#https://www.graphiti.fr/brand/32-tom-ford?page=1