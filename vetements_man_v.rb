require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'


#require ./ファイル名
require './actuelb'
require './amr'
require './amr_f_man'
require './auzmendi_f_man'
require './coltorti_man'
require './gaudenzi'
require './leam'
require './michelef'
require './nugnes'
require './russocapri'
require './suit'
#require './wise__man' #monclerは価格違いがあるので

#selenium系
require './alducadaosta'
require './brunarosso_man'
require './blondie'
require './eleonorabonucci'
require './gb'
require './monti'
require './tessabit'
require './wise'


class VetementsVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby vetements_man_v.rb
    @category = "服"
    @price = "700"
    
    include Actuelb
    include Amr
    include AmrFarfetchMan
    include AuzmendiFarfetchMan
    include ColtortiMan
    include Gaudenzi
    include Leam
    include Michelefranzese
    include Nugnes
    include Russocapri
    include Suit
    #include WiseFarfetchMan

    #seleniumm系
    include Alducadaosta
    include BrunarossoMan
    include Blondie
    include Eleonorabonucci
    include Gb
    include Monti
    include Tessabit
    include Wise

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

ATTACK_LIST_URL = [
  "https://www.coltortiboutique.com/it/designer/vetements?cat=151",
  "https://www.michelefranzesemoda.com/it/uomo/designer/vetements/",
  
  #以下selenium
  "https://www.alducadaosta.com/it/uomo/designer/vetements",
  "https://www.gebnegozionline.com/it_it/uomo/designers/vetements.html",
  "https://www.tessabit.com/it_it/uomo/designers/vetements.html",
  "https://www.wiseboutique.com/it_it/uomo/designers/vetements.html",
  "https://www.blondieshop.com/it/uomo/man-designer/vetements.html"
]

    vetements_vip_man = VetementsVipMan.new
    @price = VetementsVipMan.call_price
    @category = VetementsVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/vetements?cat=151"
            vetements_vip_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/vetements/"
            vetements_vip_man.michele_crawl(attack_site_url, @price)
            #価格調整無し
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/vetements"
        vetements_vip_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
        when "https://www.blondieshop.com/it/uomo/man-designer/vetements.html"
            vetements_vip_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/vetements.html"
            vetements_vip_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/vetements.html"
            vetements_vip_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/vetements.html"
            vetements_vip_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end