require 'rubygems'
require 'nokogiri'
require 'open-uri'


require './mycompanero'
require './lidia'
require './wise'
require './smets'
require './julian'
require './vietti'
require './luisa_world'
require './grifo'
#require './pl_line'
require './labels'


require './cortecci'


#✓dopeファクトリーファクトリーはオリジナルサイトをクロールすること

class MonclerNormalMan
    
    #include + クラス名
    include Mycompanero
    include Lidia
    include Smets
    include Julian #0サイズあるよ
    include Vietti
    include LuisaWorld
    include Grifo
    #include Plline
    include Labels

    include Wise
    include Cortecci

    #服 靴 バッグ アクセ の4種類で対応する
    #価格入力欄
    @category = "靴"
    @price = "365"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [#"https://www.lidiashopping.com/en/IT/men/t/designers/moncler",
    #"https://www.mycompanero.com/fr/brand/2-moncler?categories=homme",
    #"https://smets.lu/collections/moncler/men",
    #"https://www.wiseboutique.com/it_it/uomo/designers/moncler.html",
    #"https://www.corteccisiena.it/shop/it/brand/uomo/moncler",
    #"https://www.julian-fashion.com/it-IT/uomo/designer/moncler",
    #"https://www.viettishop.com/it/designers/moncler?cat=462",
    #"https://www.luisaworld.com/product-category/man/?product_brand=moncler",
    #"https://grifo210.com/een/catalog/category/view/s/moncler/id/389/?sale=0",
    #"https://www.pl-line.com/en/moncler?gender=men"
    "https://shop.labelsfashion.com/men/designers/moncler"
]

    moncler_n_man = MonclerNormalMan.new
    @price = MonclerNormalMan.call_price
    @category = MonclerNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.mycompanero.com/fr/brand/2-moncler?categories=homme" then
            moncler_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/men/t/designers/moncler" then
            moncler_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://smets.lu/collections/moncler/men" then
            moncler_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/uomo/designers/moncler.html" then
            moncler_n_man.wMise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.corteccisiena.it/shop/it/brand/uomo/moncler" then
            moncler_n_man.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/it-IT/uomo/designer/moncler" then
            moncler_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/moncler" then
            moncler_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/man/?product_brand=moncler" then
            moncler_n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/een/catalog/category/view/s/moncler/id/389/?sale=0" then
            moncler_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.pl-line.com/en/moncler?gender=men" then
            moncler_n_man.plline_crawl(attack_site_url, @price)
            #小数点削除必要無し
        when "https://shop.labelsfashion.com/men/designers/moncler" then
            moncler_n_man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end
