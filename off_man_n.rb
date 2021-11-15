require 'rubygems'
require 'nokogiri'
require 'open-uri'

#smetsで異常あり
#genteで異常あり

#./'ファイル名'
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


#クローリング不可能なサイト
#https://www.antonia.it/jp/brands/moncler?cat=3
#https://www.thedoublef.com/it_en/man/designers/moncler/
#https://www.dellogliostore.com/jp/designer/102247/moncler-men



class OffManNormal

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "420"
    
    #include + クラス名
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
    #"https://www.ekseption.com/ot_en/designers/off_white?cat=84",
    #"https://grifo210.com/en/men/designers/off-white.html?sale=0",
    #"https://www.julian-fashion.com/en-IT/men/designer/off_white",
    #"https://www.lidiashopping.com/en/IT/men/t/designers/off-white",
    #"https://www.mycompanero.com/fr/brand/38-off-white?categories=homme",
    #"https://smets.lu/collections/off-white/men",
    #"https://www.viettishop.com/it/designers/off-white?cat=462",
    #selenium
    #"https://www.credomen.com/offwhite/",
    #"https://www.genteroma.com/it/designer/uomo/off-white.html",
    "https://shop.labelsfashion.com/men/designers/off-white",
    "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/off-white-man",
    "https://www.papinistore.com/en/64_off-white",
    "https://www.pl-line.com/en/off-white",
    "https://www.spinnakerboutique.it/en/men#/manFilters=287&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
    #selle品 "https://www.spinnakerboutique.it/en/sale-2#/manFilters=287&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1",
]

    off_man_n = OffManNormal.new
    @price = OffManNormal.call_price
    @category = OffManNormal.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.ekseption.com/ot_en/designers/off_white?cat=84"
            off_man_n.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/en/men/designers/off-white.html?sale=0"
            off_man_n.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/men/designer/off_white"
            off_man_n.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.lidiashopping.com/en/IT/men/t/designers/off-white"
            off_man_n.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.mycompanero.com/fr/brand/38-off-white?categories=homme"
            off_man_n.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
            puts "my終了"
        #when "https://smets.lu/collections/off-white/men"
        #    off_man_n.smets_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #    puts "sm終了"
        when "https://www.viettishop.com/it/designers/off-white?cat=462"
            off_man_n.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            puts "noko終了"

            #以下selenium
        when "https://www.credomen.com/offwhite/"
            off_man_n.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.genteroma.com/it/designer/uomo/off-white.html"
            off_man_n.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://shop.labelsfashion.com/men/designers/off-white"
            off_man_n.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/off-white-man"
            off_man_n.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.papinistore.com/en/64_off-white"
            off_man_n.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.pl-line.com/en/off-white"
            off_man_n.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.it/en/men#/manFilters=287&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
            off_man_n.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        #spineのsell
        #when "https://www.spinnakerboutique.it/en/sale-2#/manFilters=287&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
        #    off_man_n.spinnnaker_crawl_selenium(attack_site_url, @price)
        #    #小数点削除必要無し 
        end
    end