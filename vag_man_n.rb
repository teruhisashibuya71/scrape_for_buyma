require 'rubygems'
require 'nokogiri'
require 'open-uri'

#./'ファイル名'
require './capsel'
require './cortecci'
require './ekseption'
require './grifo'
require './julian'
require './lidia'
require './luisa_world'
require './mycompanero'
require './ottodisapietro'
require './smets'
require './vietti'

#以下selenium
require './credoman'
require './labels'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'

class ValentinogNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby vag_man_n.rb
    @category = "服"
    @price = "450"
    
    #include + クラス名
    include Capsel
    include Cortecci
    include Ekseption
    include Grifo
    include Julian #0サイズあるよ
    include Lidia
    include LuisaWorld
    include Mycompanero
    include Ottodisapietro
    include Smets
    include Vietti
    
    #selenium
    include Credoman
    include Genteroma
    include Labels
    include Papini
    include Plline
    include Spinnaker
    
    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.capsulebyeso.com/en/men-valentino", #靴とかバッグもあるので...
    "https://www.capsulebyeso.com/en/men-valentino+garavani",
    #"https://grifo210.com/en/catalog/category/view/s/valentino-garavani/id/493/?sale=0",
    #"https://www.julian-fashion.com/en-IT/men/designer/valentino_garavani",
    #"https://www.luisaworld.com/product-category/man/?product_brand=valentino-GARAVANI",
    #"https://www.mycompanero.com/fr/brand/10-valentino?categories=homme", #アクセだけ?
    #"https://smets.lu/collections/valentino/men",
    #"https://www.viettishop.com/it/designers/valentino-garavani?cat=462",
    #
    ##以下selenium
    #"https://www.credomen.com/valentino/",
    #"https://www.genteroma.com/it/designer/uomo/valentino-garavani.html",
    #"https://www.papinistore.com/en/11_valentino-garavani", #レディースも入る
    #"https://www.spinnakerboutique.it/en/men#/manFilters=103&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1",
    ##セール品 "https://www.spinnakerboutique.it/en/sale-2#/manFilters=102&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
    #"https://www.pl-line.com/en/valentino"
]

    vag_n_man = ValentinogNormalMan.new
    @price = ValentinogNormalMan.call_price
    @category = ValentinogNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.capsulebyeso.com/en/men-valentino"
            vag_n_man.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.capsulebyeso.com/en/men-valentino+garavani"
            vag_n_man.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://grifo210.com/en/catalog/category/view/s/valentino-garavani/id/493/?sale=0"
            vag_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/valentino_garavani"
            vag_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/man/?product_brand=valentino-GARAVANI"
            vag_n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/brand/10-valentino?categories=homme"  #アクセだけ?
            vag_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/valentino/men"
            vag_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/valentino-garavani?cat=462"
            vag_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

            #以下selenium
        when "https://www.credomen.com/valentino/"
            vag_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/valentino-garavani.html"
            vag_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.papinistore.com/en/11_valentino-garavani", #レディースも一緒に検索されてしまう
            vag_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when  "https://www.pl-line.com/en/valentino"
            vag_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.it/en/men#/manFilters=103&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
            vag_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        #セール品ページ
        #when "https://www.spinnakerboutique.it/en/sale-2#/manFilters=102&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
        #    vag_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
        #    #小数点削除必要無し
        end
    end