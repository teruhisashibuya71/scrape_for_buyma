require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

class OffManNormal
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby off_man_n.rb
    @category = "アクセ"
    @price = "1195"
    @currency = 150.1
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Corsocomo, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti
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
    "https://www.ekseption.com/ot_en/designers/off_white?cat=84",
    "https://grifo210.com/en/men/designers/off-white.html?sale=0",
    "https://www.julian-fashion.com/en-IT/men/designer/off_white",
    "https://www.lidiashopping.com/en/IT/men/t/designers/off-white",
    "https://www.mycompanero.com/fr/brand/38-off-white?categories=homme",
    "https://smets.lu/collections/off-white/men",
    "https://viettishop.com/collections/off-white/men",
    #selenium
    "https://www.credomen.com/offwhite/",
    "https://www.genteroma.com/it/designer/uomo/off-white.html",
    "https://shop.labelsfashion.com/men/designers/off-white",
    "https://www.pl-line.com/en/off-white",
    "https://www.spinnakerboutique.com/en-IT/man/designer/off_white",
    "https://www.farfetch.com/it/shopping/men/off-white/items.aspx", #farfetch
    "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/off-white-man",
    "https://www.papinistore.com/en/64_off-white"
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
        #when "https://smets.lu/collections/off-white/men"
        #    off_man_n.smets_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #    puts "sm終了"
        when "https://viettishop.com/collections/off-white/men"
            off_man_n.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")
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
        when "https://www.spinnakerboutique.com/en-IT/man/designer/off_white"
            off_man_n.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        #spinenakerのセールアイテムのページ
        #when "https://www.spinnakerboutique.it/en/sale-2#/manFilters=287&pageSize=36&viewMode=grid&orderBy=15&pageNumber=1"
        #    off_man_n.spinnnaker_crawl_selenium(attack_site_url, @price)
        #    #小数点削除必要無し
        # when "https://www.farfetch.com/it/shopping/men/off-white/items.aspx"
        #     off_man_n.plline_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        end
    end


#クローリング不可能なサイト
#https://www.antonia.it/jp/brands/moncler?cat=3
#https://www.thedoublef.com/it_en/man/designers/moncler/
#https://www.dellogliostore.com/jp/designer/102247/moncler-men
#https://www.fouramsterdam.com/ow-shirt-omga133f21fab001-1001-black.html
#https://www.santaeulalia.com/ru/man/brand/off-white.html
