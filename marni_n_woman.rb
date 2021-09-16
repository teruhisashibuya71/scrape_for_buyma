#require './ファイル名'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

require './mycompanero'
require './dafne'
require './vietti'
require './aldogibilaro'
#require './dante5'
require './bernardelli'


class MarniWoman

    #include + クラス名
    include Mycompanero
    include Dafne
    include Vietti
    include Aldogibilaro
    #include Dante5
    include Bernardelli
    

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "アクセ"
    @price = "540"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    #"https://www.mycompanero.com/en/brand/27-marni",
    #"https://www.dafneshop.it/collections/marni",
    #"https://www.viettishop.com/it/designers/marni?cat=456",
    #"https://www.aldogibilaro.com/it/10000252_marni",
    #"https://www.dante5.com/en-IT/women/designer/marni"
    #"https://www.bernardellistores.com/it/donna/marni?order=LATEST"
    "https://www.bernardellistores.com/it/donna/marni"
    ]

    marni_woman = MarniWoman.new
    @price = MarniWoman.call_price
    @category = MarniWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url

        when "https://www.mycompanero.com/en/brand/27-marni" then
            marni_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.dafneshop.it/collections/marni" then
            marni_woman.dafne_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.viettishop.com/it/designers/marni?cat=456" then
            marni_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.aldogibilaro.com/it/10000252_marni" then
            marni_woman.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.dante5.com/en-IT/women/designer/marni" then
            marni_woman.dante_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.bernardellistores.com/it/donna/marni" then
            marni_woman.bernardelli_crawl_selenium(attack_site_url, @price)
            #処理無し @price = @price.delete(".")
        end
    end
