require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#https://en.cjcouture.com/collections/jil-sander
#https://www.antonia.it/jp/brands/jil_sander
#https://www.playgroundshop.com/en/jil-sander/woman/?nodi_ID=7511
#https://www.pozzilei.it/women/jilsander?order=LATEST
#https://bungalow.store/de/women/designer/jil-sander/
#https://www.giuliofashion.com/collections/jil-sander/woman?usf_sort=-date
#https://www.susi.it/en-GB/search/f/jil-sander/
#https://ceneregb.com/collections/donna-designers-jil-sander
#https://www.10corsocomo-theshoponline.com/ita_en/brand/jil-sander-woman
#https://www.harveynichols.com/int/brand/jil-sander/womens/
#https://www.tizianafausti.com/it_it/brand/jil-sander-donna
#https://www.lungolivignofashion.com/en-TR/women/designer/jil_sander?currPage=3
#https://www.baseblu.com/it/designer/jil-sander.html?gender=woman&categorie=donna
#https://www.lungolivignofashion.com/en-TR/women/designer/jil_sander?currPage=3
#https://stivalilisboa.com/en/products?&designer=734
#https://shop.doverstreetmarket.com/collections/jil-sander-view-all
#https://www.emerson-renaldi.com/en/Designers/Jil-Sander/
#https://www.baseblu.com/it/designer/jil-sander.html?gender=woman&categorie=donna
#"https://www.vooberlin.com/jil-sander/"
#https://www.nathalieschuterman.com/en/shop/bags/handbags/jil-sander-link-vaska-brown
class JilsanderWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby jilsander_woman_n.rb
    @category = "服"
    @price = "200"
    @currency = 141.6
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo ,Julian, Lidia, LuisaWorld, Mycompanero, Smets
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
    "https://www.ekseption.com/ot_en/designers/jil_sander",
    "https://grifo210.com/it/catalog/category/view/s/jil-sander/id/534/",
    "https://www.julian-fashion.com/it-IT/donna/designer/jil_sander",
    "https://www.ilduomo.it/designer/jil-sander.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc",
    "https://www.lidiashopping.com/en/IT/women/t/designers/jil-sander",
    "https://smets.lu/collections/jil-sander",

    #selenium
    "https://www.bernardellistores.com/it/women/jil-sander",
    "https://www.genteroma.com/it/designer/donna/jil-sander.html",
    "https://labelsfashion.com/collections/women-jil-sander",
    #"https://ottodisanpietro.com/collections/jil-sander-women",
    "https://www.viettishop.com/en/women/designers/jil-sander"
]

jilsander_woman = JilsanderWoman.new
@price = JilsanderWoman.call_price
@category = JilsanderWoman.call_category
@currency = JilsanderWoman.call_currency

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.ekseption.com/ot_en/designers/jil_sander"
        jilsander_woman.ekseption_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://grifo210.com/it/catalog/category/view/s/jil-sander/id/534/"
        jilsander_woman.grifo_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.ilduomo.it/designer/jil-sander.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc"
        jilsander_woman.ilduomo_crawl(attack_site_url, @price, @currency)
        #日本円調整のため小数点調整 無し
    when "https://www.julian-fashion.com/it-IT/donna/designer/jil_sander"
        jilsander_woman.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.lidiashopping.com/en/IT/women/t/designers/jil-sander"
        jilsander_woman.lidia_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://smets.lu/collections/jil-sander"
        jilsander_woman.smets_crawl(attack_site_url, @price)
        @price = @price.delete(".")

    #selenium
    when "https://www.bernardellistores.com/it/women/jil-sander"
        jilsander_woman.bernardelli_crawl_selenium(attack_site_url, @price)
        #小数点調整なし
    when "https://www.genteroma.com/it/designer/donna/jil-sander.html"
        jilsander_woman.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://labelsfashion.com/collections/women-jil-sander"
        jilsander_woman.labels_crawl_selenium(attack_site_url, @price)
        #小数点調整は呼び出し元で行う
    when "https://ottodisanpietro.com/collections/jil-sander-women"
        jilsander_woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.viettishop.com/en/women/designers/jil-sander"
        jilsander_woman.vietti_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    end

end