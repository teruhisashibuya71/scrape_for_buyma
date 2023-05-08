require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'
#一旦完成

class MarniVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby marni_man_v.rb
    @category = "服"
    @price = "425"
    include Nugnes, ColtortiMan, Eleonorabonucci
    include AngeloMinetti, BrunarossoMan, Gb, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end
ATTACK_LIST_URL = [
    "https://nugnes1920.com/collections/marni-man",
    "https://www.coltortiboutique.com/it/designer/marni?cat=151",
    "https://eleonorabonucci.com/en/marni/men/new-collection",
    #https://harresoe.com/collections/marni
    #以下selenium
    "https://www.minettiangeloonline.com/it/man?idt=176",
    "https://vip.brunarosso.com/s/designers/marni/?category=men",
    "https://www.gebnegozionline.com/it_it/uomo/designers/marni.html",
    "https://www.wiseboutique.com/it_it/uomo/designers/marni.html"
]

    marni_vip_man = MarniVipMan.new
    @price = MarniVipMan.call_price
    @category = MarniVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://nugnes1920.com/collections/marni-man"
            marni_vip_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151" 
            marni_vip_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/marni/men/new-collection"
            marni_vip_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
            #以下 selenium

        when "https://www.minettiangeloonline.com/it/man?idt=176" 
            marni_vip_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/maison-margiela/?category=men" 
            marni_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #商品桁数はいじらない
        when "https://www.gebnegozionline.com/it_it/uomo/designers/marni.html"
            marni_vip_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/uomo/designers/marni.html"
            marni_vip_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")    
        end
    end



#出品順序
#1.mietti
#2.coltortiboutique
#3.brunarosso
#2.alducadaosta


#https://nugnes1920.com/collections/marni-man
#以下selenium

#https://eleonorabonucci.com/en/marni/men/new-collection
#https://eleonorabonucci.com/EN/marni/men/sale
#https://www.gebnegozionline.com/it_it/uomo/designers/marni.html
#https://www.wiseboutique.com/it_it/uomo/designers/marni.html


##require ./ファイル名
#require './nugnes'
#
##selenium系
#require './eleonorabonucci'
#require './gb'
#require './wise'