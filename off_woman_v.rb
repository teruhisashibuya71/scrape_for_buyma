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


class VipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby off_woman_v.rb
    @category = "服"
    @price = "595"
    
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
  # なくなった"https://actuelb.com/en/571-women-s-off-white",
  #"https://amrstore.com/collections/off-white",
  #"https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&designer=1205035",
  #"https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=1205035",
  #"https://www.coltortiboutique.com/it/designer/off_white?cat=166",
  #"https://www.gaudenziboutique.com/en-it/women/designer/off_white",
  #"https://www.leam.com/it_eu/designer/off-white-donna.html",
  #"https://www.michelefranzesemoda.com/it/donna/designer/off-white/",
  #"https://nugnes1920.com/collections/off-white-woman",
  ##"https://www.russocapri.com/it/tutti/designer/off-white/gruppi",
  "https://www.russocapri.com/it/donna/designer/off-white/gruppi",
  "https://suitnegozi.com/collections/off-white-donna",
  
  #以下selenium
  "https://www.alducadaosta.com/it/donna/designer/offwhite",
  "https://www.brunarosso.com/s/designers/off-white/?category=women",
  "https://www.gebnegozionline.com/it_it/donna/designers/off-white.html", 
  "https://www.wiseboutique.com/it_it/donna/designers/off-white.html",
  "https://www.tessabit.com/it_it/donna/designers/off-white.html",
  "https://www.montiboutique.com/it-IT/donna/designer/off_white", 
  "https://www.blondieshop.com/it/donna/woman-designer/off-white.html"
]

    vip__woman = VipWoman.new
    @price = VipWoman.call_price
    @category = VipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/571-women-s-off-white"
            vip__woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/off-white"
            vip__woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&designer=1205035"
            vip__woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=1205035"
            vip__woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/off_white?cat=166"
            vip__woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/off_white"
            vip__woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/off-white-donna.html"
            vip__woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/donna/designer/off-white/"
            vip__woman.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://nugnes1920.com/collections/off-white-woman"
            vip__woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/designer/off-white/gruppi"
            vip__woman.russo_crawl(attack_site_url, @price)
            #価格のドット調整無し
        when "https://suitnegozi.com/collections/off-white-donna"
            vip__woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/offwhite"
            vip__woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/off-white/?category=women"
            vip__woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/off-white.html"
            vip__woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/off-white.html"
            vip__woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/off_white"
            vip__woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/off-white.html"
            vip__woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/off-white.html"
            vip__woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end
