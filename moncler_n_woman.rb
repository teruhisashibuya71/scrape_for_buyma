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

require './cortecci'


#✓dopeファクトリーファクトリーはオリジナルサイトをクロールすること

class MonclerNormalWoman
    
    #include + クラス名
    include Mycompanero
    include Lidia
    include Smets
    include Julian #0サイズあるよ
    include Vietti
    include LuisaWorld
    include Grifo
    
    include Wise
    include Cortecci

    #服 靴 バッグ アクセ の4種類で対応する
    #価格入力欄
    @category = "バッグ"
    @price = "130"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [#"https://www.mycompanero.com/fr/brand/2-moncler?categories=femme",
    #"https://www.lidiashopping.com/en/IT/women/t/designers/moncler",
    #"https://smets.lu/collections/moncler/women",
    #"https://www.wiseboutique.com/it_it/donna/designers/moncler.html"
    #"https://www.corteccisiena.it/shop/it/brand/donna/moncler",
    #"https://www.julian-fashion.com/it-IT/donna/designer/moncler"
    #"https://www.viettishop.com/it/designers/moncler?cat=456"
    #"https://www.luisaworld.com/product-category/woman/?product_brand=moncler,
    "https://grifo210.com/een/woman/designers/moncler.html?sale=0"
    ]


    moncler_n_woman = MonclerNormalWoman.new
    @price = MonclerNormalWoman.call_price
    @category = MonclerNormalWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.mycompanero.com/fr/brand/2-moncler?categories=femme" then
            moncler_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/women/t/designers/moncler" then
            moncler_n_woman.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://smets.lu/collections/moncler/women" then
            moncler_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/moncler.html" then
            moncler_n_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")    
        when "https://www.corteccisiena.it/shop/it/brand/donna/moncler" then
            moncler_n_woman.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/it-IT/donna/designer/moncler" then
            moncler_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/it-IT/donna/designer/moncler" then
            moncler_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/moncler?cat=456" then
            moncler_n_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/woman/?product_brand=moncler" then
            moncler_n_woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/een/woman/designers/moncler.html?sale=0" then
            moncler_n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(",")
            
        end
    end
