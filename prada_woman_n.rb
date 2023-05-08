require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

class PradaNormalWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby prada_woman_n.rb
    @category = "靴"
    @price = "1950"
    @currency = 144.2
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
    "https://www.julian-fashion.com/en-IT/women/designer/prada",
    "https://www.ilduomo.it/designer/prada.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc",
    "https://www.mycompanero.com/fr/brand/13-prada?categories=femme",
    "https://smets.lu/collections/prada/women",
    #"https://www.viettishop.com/it/designers/prada?cat=456",
    #以下selenium
    "https://www.genteroma.com/it/designer/donna/prada.html",
    #"https://www.ottodisanpietro.com/eu_en/woman-fashion/woman-designers/prada-woman",
    "https://www.pl-line.com/en/prada",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/prada"
]

prada_n_woman = PradaNormalWoman.new
@price = PradaNormalWoman.call_price
@category = PradaNormalWoman.call_category
@currency = PradaNormalWoman.call_currency

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.julian-fashion.com/en-IT/women/designer/prada"
        prada_n_woman.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.ilduomo.it/designer/prada.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc" 
        prada_n_woman.ilduomo_crawl(attack_site_url, @price, @currency)
        #日本円調整のため小数点調整 無し
    when "https://www.mycompanero.com/fr/brand/13-prada?categories=femme"
        prada_n_woman.mycompanero_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://smets.lu/collections/prada/women"
        prada_n_woman.smets_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.viettishop.com/it/designers/prada?cat=456"
        prada_n_woman.vietti_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")

    #以下selenium
    when "https://www.genteroma.com/it/designer/donna/prada.html"
        prada_n_woman.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.ottodisanpietro.com/eu_en/woman-fashion/woman-designers/prada-woman"
        prada_n_woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.pl-line.com/en/prada"
        prada_n_woman.plline_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.spinnakerboutique.com/it-IT/donna/designer/prada"
        prada_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し 
    end
end

#https://www.franzkraler.com/at/de/designer/prada
#https://pianoluigi.com/en-jp/a/search?q=prada&type=product