require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#corsocomoまで改修済み 4/23
#vietti再度改修済み 4/23
class NormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "800"
    @currency = 
    #include + クラス名
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets, Vietti
    include Bernardelli, Corsocomo, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, WrongWeather
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
    https://www.aldogibilaro.com/en/brands
    https://www.capsulebyeso.com/en/brand.html
    https://www.corteccisiena.it/shop/home
    https://www.ekseption.com/ot_es/designers?___store=ot_es&___from_store=ot_en
    https://www.lidiashopping.com/en/IT/men/designers
    https://www.julian-fashion.com/en-IT/men/designers
    https://www.luisaworld.com/mens-designers/
    https://www.mycompanero.com/fr/
    https://smets.lu/pages/brands-men
    https://viettishop.com/it/pages/mens-brands

    #以下selenium
    #selenium
    https://www.bernardellistores.com/it/brands#man
    https://10corsocomo.com/pages/brands
    https://www.credomen.com/
    https://www.dante5.com/it-IT/uomo/designers
    https://www.genteroma.com/it/designers/gender/male/
    https://grifo210.com/it/designers-uomo
    https://shop.labelsfashion.com/men/designers
    https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers
    https://www.papinistore.com/designers
    https://www.pl-line.com/en/brands
    https://www.viettishop.com/it/designer-donna
    https://www.wrongweather.net/it
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
            _man.vietti_crawl(attack_site_url, @price)
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
            _man.grifo_crawl_selenium(attack_site_url, @price)
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
        when ""
            _man.wrong_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        
        #farfetch
        when ""
            _man.farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        end
    end
