require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#ilduomoまで改修済み 1/15
class DgNormalWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby dg_woman_n.rb
    @category = "服"
    @price = "795"
    @currency = 144.3
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
    # 例外処理するべきかも "https://www.aldogibilaro.com/en/10000085_dolce-gabbana",
    "https://grifo210.com/it/donna/designers/dolce-gabbana.html?sale=0",
    "https://www.ilduomo.it/designer/dolce-gabbana.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc",
    "https://www.lidiashopping.com/en/IT/women/t/designers/dolce-and-gabbana",
    "https://www.julian-fashion.com/en-IT/women/designer/dolce_and_gabbana",
    "https://www.luisaworld.com/woman/designers/dolce-gabbana/",
    "https://www.mycompanero.com/en/brand/90-dolce-gabbana",

    #selenium
    "https://www.genteroma.com/it/designer/donna/dolce-gabbana.html",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/dolce___gabbana",
    # サイト改修あり 商品なし "https://viettishop.com/it/collections/dolce-gabbana/women"
]

    dg_n_woman = DgNormalWoman.new
    @price = DgNormalWoman.call_price
    @category = DgNormalWoman.call_category
    @currency = DgNormalWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.aldogibilaro.com/en/10000085_dolce-gabbana"
            dg_n_woman.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://grifo210.com/it/donna/designers/dolce-gabbana.html?sale=0"
            dg_n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.ilduomo.it/designer/dolce-gabbana.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc"
            dg_n_woman.ilduomo_crawl(attack_site_url, @price, @currnecy)
            #日本円調整のため小数点調整 無し
        when "https://www.julian-fashion.com/en-IT/women/designer/dolce_and_gabbana"
            dg_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/women/t/designers/dolce-and-gabbana"
            dg_n_woman.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/woman/designers/dolce-gabbana/"
            dg_n_woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/en/brand/90-dolce-gabbana"
            dg_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")

        #以下selenium
        when "https://www.genteroma.com/it/designer/donna/dolce-gabbana.html"
            dg_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.spinnakerboutique.com/it-IT/donna/designer/dolce___gabbana"
            dg_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        # 商品なしのため
        # when "https://viettishop.com/it/collections/dolce-gabbana/women"
        #     dg_n_woman.vietti_crawl_selenium(attack_site_url, @price)
        #     @price = @price.delete(".")
        end
    end
