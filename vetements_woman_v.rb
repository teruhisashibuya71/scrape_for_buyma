require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


#require ./ファイル名
require './actuelb'
require './auzmendi_f_woman'
require './amr'
require './amr_f_woman'
require './coltorti_woman'
require './gaudenzi'
require './leam'
require './michelef'
require './nugnes'
require './russocapri'
require './sigrun'
require './suit'
require './wise_f_woman' #monclerの価格違いあるので

#selenium系
require './alducadaosta'
require './brunarosso_woman'
require './blondie'
require './eleonorabonucci' #サイズ35〜
require './gb'
require './monti'
require './tessabit'
require './wise'


class VetementsVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby vetements_woman_v.rb
    @category = "服"
    @price = "700"
    
    include Actuelb
    include Amr
    include AmrFarfetchWoman
    include AuzmendiFarfetchWoman
    include ColtortiWoman
    include Gaudenzi
    include Leam
    include Michelefranzese
    include Nugnes
    include Russocapri
    include SigrunWoehr
    include Suit
    include WiseFarfetchWoman

    #seleniumm系
    include Alducadaosta
    include BrunarossoWoman
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
  "https://www.coltortiboutique.com/it/designer/vetements?cat=166",
  "https://nugnes1920.com/collections/vetements-woman",
  #以下selenium
  "https://www.alducadaosta.com/it/donna/designer/vetements",
  "https://www.gebnegozionline.com/it_it/donna/designers/vetements.html",
  "https://www.tessabit.com/it_it/donna/designers/vetements.html",
  "https://www.wiseboutique.com/it_it/donna/designers/vetements.html",
  "https://www.blondieshop.com/it/donna/woman-designer/vetements.html"
]

    vip_vetements_woman = VetementsVipWoman.new
    @price = VetementsVipWoman.call_price
    @category = VetementsVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/vetements?cat=166"
          vip_vetements_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/vetements-woman"
          vip_vetements_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/vetements"
          vip_vetements_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/donna/woman-designer/vetements.html"
          vip_vetements_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/vetements.html"
          vip_vetements_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/vetements.html"
          vip_vetements_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/vetements.html"
          vip_vetements_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end
