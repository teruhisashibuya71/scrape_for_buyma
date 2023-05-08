require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#corsocomoまで改修済み 4/23
class NormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "800"
    @currency = 
    #include + クラス名
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
    #nokogiri系
    #レディースのみ https://www.aldogibilaro.com/en/10000250_jimmy-choo
    https://www.julian-fashion.com/en-IT/men/designer/jimmy_choo
    
    #selenium
    
]

    _man = NormalMan.new
    @price = NormalMan.call_price
    @category = NormalMan.call_category
    @ccurrency = NormalWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when ""
            _man.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")   
        when ""
            _man.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            _man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _man.ilduomo_crawl(attack_site_url, @price, @currnecy)
            #日本円調整のため小数点調整 無し
        when ""
            _man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            _man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            _man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.vietti_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when ""
            _man.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when ""
            _man.corsocomo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when ""
            _man.dante5_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when ""
            _man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when ""
            _man.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            _man.papini_crawl_selenium(attack_site_url, @price, @currency)
            #小数点削除必要無し
        when ""
            _man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when ""
            _man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        
        #farfetch
        when ""
            _man.farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        end
    end
