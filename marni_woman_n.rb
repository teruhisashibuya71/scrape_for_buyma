#require './ファイル名'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#https://bungalow.store/de/women/designer/marni/?p=2
#https://whyareyouhere.jp/women/brands/marni/?features_hash=316-7674
#https://www.24s.com/en-jp/p_MNI3C344BEIAZAAA00?gclid=CjwKCAjwxZqSBhAHEiwASr9n9E-V-JtHE20ExVqtWdS2M0Bt8wGITx0ZtRdtHEdpvOmcmQkf2D2MARoCrDsQAvD_BwE&gclsrc=aw.ds
#https://www.megusta.nl/women/brands/view-all-brands/page3.html?brand=4353000

class MarniWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby marni_woman_n.rb
    @category = "靴"
    @price = "590"
    @currency = 149.2
    include Aldogibilaro, Capsel, Cortecci, Dafne, Ekseption, Grifo, Ilduomo ,Julian, Lidia, LuisaWorld, Mycompanero, Smets, Vietti
    include Bernardelli, Corsocomo, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
    def self.call_curency
        @currency
    end
end

ATTACK_LIST_URL = [
     # MARNIだけ」動かない "https://www.aldogibilaro.com/it/10000252_marni",
    "https://www.capsulebyeso.com/en/women-marni",
    "https://www.ilduomo.it/designer/marni.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc",
    "https://www.julian-fashion.com/en-IT/women/designer/marni",
    "https://www.lidiashopping.com/en/IT/women/t/designers/marni",
    "https://www.dafneshop.it/collections/marni",
    "https://viettishop.com/collections/marni/women",

    ##selenium
    "https://www.bernardellistores.com/it/donna/marni",
    "https://10corsocomo.com/en-jp/collections/marni?filter.p.m.elastick.gender=Woman",
    #なくなった "https://www.dante5.com/en-IT/women/designer/marni",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/marni",
    "https://grifo210.com/it/donna/designers/marni.html"

    #veja × marni
    #"https://www.ekseption.com/ot_en/designers/veja_x_marni",

    #mariadonna 送料無料
    ]

    marni_woman = MarniWoman.new
    @price = MarniWoman.call_price
    @category = MarniWoman.call_category
    @currency = MarniWoman.call_curency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
         #when "https://www.aldogibilaro.com/it/10000252_marni"
         #    marni_woman.aldogibilaro_crawl(attack_site_url, @price)
         #    @price = @price.delete(".")
        when "https://www.capsulebyeso.com/en/women-marni"
            marni_woman.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")  
        when "https://www.dafneshop.it/collections/marni"
            marni_woman.dafne_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.ilduomo.it/designer/marni.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc"
            marni_woman.ilduomo_crawl(attack_site_url, @price, @currency)
            #日本円調整のため小数点調整 無し
        when "https://www.julian-fashion.com/en-IT/women/designer/marni"
            marni_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/women/t/designers/marni"
            marni_woman.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://viettishop.com/collections/marni/women"
            marni_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".") #再再改修
        #selenium
        when "https://www.bernardellistores.com/it/donna/marni"
            marni_woman.bernardelli_crawl_selenium(attack_site_url, @price)
        #処理無し @price = @price.delete(".")
        # when "https://www.dante5.com/en-IT/women/designer/marni"
        #     marni_woman.dante5_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://10corsocomo.com/en-jp/collections/marni?filter.p.m.elastick.gender=Woman"
            marni_woman.corsocomo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://grifo210.com/it/donna/designers/marni.html"
            marni_woman.grifo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.spinnakerboutique.com/it-IT/donna/designer/marni"
            marni_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://viettishop.com/collections/marni/women"
            marni_woman.vietti_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end


#https://palazzobelli.it/sweatshirts/15794-36351-white-pink-and-blue-cotton-sweatshirtkpmk.html#/2160-size-40
#https://www.societeanonyme.it/en/15-clothing?q=Brand-MARNI
#https://stylemyle.com/shop/products/marni-9082267f-c8c1-4dd4-a8dd-c9b2102bc345?awc=22486_1675589957_a4bd179ac16e807eae0673b919968202#modesens=1
#https://beamhill.fi/beamhill-brand-categories/marni/
#https://www.theoutnet.com/en-au/shop/designers/marni
