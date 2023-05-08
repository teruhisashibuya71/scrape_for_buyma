require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#corsocomoまで改修済み 4/23
class NormalWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby 
    @category = "服"
    @price = "890"
    @currency = 
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets, Vietti
    include Bernardelli, Corsocomo, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Pozzilei, Spinnaker, WrongWeather
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
    https://grifo210.com/en/designers-woman
    https://www.ilduomo.it/designers
    https://www.lidiashopping.com/en/IT/women/designers
    https://www.julian-fashion.com/en-IT/women/designers
    https://www.luisaworld.com/womens-designers/
    https://www.mycompanero.com/fr/
    https://smets.lu/pages/brands-women

    #selenium
    https://www.bernardellistores.com/it/brands#woman
    https://10corsocomo.com/pages/brands
    https://www.dante5.com/it-IT/donna/designers
    https://www.genteroma.com/it/designers/gender/female/
    https://labelsfashion.com/pages/womenswear-brands-designers
    https://www.ottodisanpietro.com/eu_en/woman-fashion/woman-designers
    https://www.papinistore.com/donna-brand2
    https://www.pl-line.com/en/brands
    https://www.spinnakerboutique.com/it-IT/donna/designers
    https://www.viettishop.com/it/designer-donna
]

    _woman = NormalWoman.new
    @price = NormalWoman.call_price
    @category = NormalWoman.call_category
    @ccurrency = NormalWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when 
            _woman.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _woman.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")  
        when 
            _woman.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _woman.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            _woman.ilduomo_crawl(attack_site_url, @price, @currnecy)
            #日本円調整のため小数点調整 無し
        when 
            _woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _woman.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            _woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            _woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".") #再再改修
        #以下selenium
        when 
            _woman.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点調整なし
        when 
            _woman.corsocomo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _woman.dante5_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when 
            _woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _woman.grifo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _woman.labels_crawl_selenium(attack_site_url, @price)
            #小数点調整なし
        when 
            _woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            _woman.papini_crawl_selenium(attack_site_url, @price, @currency)
            #小数点削除必要無し
        when 
            _woman.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when
            _woman.pozzilei_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when
            _woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end








スウェーデン
https://www.nathalieschuterman.com/en/marni

https://www.lenoirboutique.com/manufacturer/max-mara.html
https://www.agnettiboutique.it/eu/brands-woman

https://www.antonia.it/it/brands?category=4

https://www.frmoda.com/en/designer/golden-goose
https://www.flanella.com/collections/woman

https://www.ceneregb.com/en/woman/designers
https://www.chirullishop.com/it/brands

https://www.divincenzoboutique.com/en/women/designers
https://www.dante5.com/it-IT/donna/designers

https://shop.jofre.eu/pages/brands

https://www.matchesfashion.com/intl/womens/designers

https://www.parisricci.com/it/brands-woman

https://www.slamjam.com/en_IT/woman/brands

https://www.thedoublef.com/it_en/man/designers




UK
https://www.zeeandco.co.uk/womens/brands
