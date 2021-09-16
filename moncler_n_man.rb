require 'rubygems'
require 'nokogiri'
require 'open-uri'

#./'ファイル名'
require './cortecci'
require './ekseption'
require './grifo'
require './lidia'
require './luisa_world'
require './julian'
require './mycompanero'
require './smets'
require './vietti'

#selenium
require './credoman'
require './labels'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'


#クローリング不可能なサイト
#https://www.antonia.it/jp/brands/moncler?cat=3
#https://www.thedoublef.com/it_en/man/designers/moncler/
#https://www.dellogliostore.com/jp/designer/102247/moncler-men



class MonclerNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    #価格入力欄
    @category = "服"
    @price = "525"
    
    #include + クラス名
    include Cortecci
    include Ekseption
    include Grifo
    include Lidia
    include LuisaWorld
    include Julian #0サイズあるよ
    include Mycompanero
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
    #"https://www.corteccisiena.it/shop/it/brand/uomo/moncler",
    #"https://www.ekseption.com/ot_en/designers/moncler?cat=84",
    #"https://grifo210.com/een/catalog/category/view/s/moncler/id/389/?sale=0",
    #"https://www.lidiashopping.com/en/IT/men/t/designers/moncler",
    #"https://www.mycompanero.com/fr/brand/2-moncler?categories=homme",
    #"https://smets.lu/collections/moncler/men",
    #"https://www.julian-fashion.com/it-IT/uomo/designer/moncler",
    #"https://www.viettishop.com/it/designers/moncler?cat=462",
    #"https://www.luisaworld.com/product-category/man/?product_brand=moncler",
    ##以下selenium
    #"https://www.credomen.com/moncler/",
    #"https://www.genteroma.com/it/designer/uomo/moncler.html",
    #"https://shop.labelsfashion.com/men/designers/moncler",
    #"https://www.papinistore.com/it/633-uomo#s-4/uomo-nuovi_arrivi/designers-moncler",
    #"https://www.pl-line.com/en/moncler?gender=men",
    "https://www.spinnakerboutique.it/en/men#/manFilters=69&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
]

    moncler_n_man = MonclerNormalMan.new
    @price = MonclerNormalMan.call_price
    @category = MonclerNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.corteccisiena.it/shop/it/brand/uomo/moncler" then
            moncler_n_man.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.ekseption.com/ot_en/designers/moncler?cat=84" then
            moncler_n_man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/een/catalog/category/view/s/moncler/id/389/?sale=0" then
            moncler_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/it-IT/uomo/designer/moncler" then
            moncler_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")    
        when "https://www.lidiashopping.com/en/IT/men/t/designers/moncler" then
            moncler_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/man/?product_brand=moncler" then
            moncler_n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/brand/2-moncler?categories=homme" then
            moncler_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/moncler/men" then
            moncler_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/moncler" then
            moncler_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

            #以下selenium
        when "https://www.credomen.com/moncler/" then
            moncler_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/moncler.html" then
            moncler_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://shop.labelsfashion.com/men/designers/moncler" then
            moncler_n_man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://lpapinistore.com/it/633-uomo#s-4/uomo-nuovi_arrivi/designers-moncler" then
            moncler_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        #when "https://www.pl-line.com/en/moncler?gender=men" then
        #    moncler_n_man.plline_crawl_selenium(attack_site_url, @price)
        #    #小数点削除必要無し
        when "https://www.spinnakerboutique.it/en/men#/manFilters=69&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1" then   
            moncler_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        end
    end
