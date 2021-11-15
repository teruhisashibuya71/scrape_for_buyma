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


class VersaceVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"
    
    include Actuelb
    include Amr
    include AmrFarfetchWoman
    include AuzmendiFarfetchWoman
    include ColtortiWoman
    include Gaudenzi
    include Leam
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
    "https://www.coltortiboutique.com/it/designer/versace?cat=166",
    "https://www.gaudenziboutique.com/en-it/women/designer/versace",
    "https://nugnes1920.com/collections/versace-woman",
    "https://www.sigrun-woehr.com/en/By-Brand/Versace/",
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/versace",
    "https://www.brunarosso.com/s/designers/versace/?category=women",
    "https://eleonorabonucci.com/en/versace/women/new-collection",
    "https://www.gebnegozionline.com/it_it/donna/designers/versace.html",
    "https://www.montiboutique.com/it-IT/donna/designer/versace",
    "https://www.tessabit.com/it_it/donna/designers/versace.html?page=1",
    "https://www.wiseboutique.com/it_it/donna/designers/versace.html"
    
    #セカンドライン
    #"https://nugnes1920.com/collections/versace-jeans-couture-woman",
    #"https://www.sigrun-woehr.com/en/By-Brand/Versace-Jeans-Couture/",
    #"https://www.brunarosso.com/s/designers/versace-jeans-couture/?category=women",
    #selenium
    #"https://eleonorabonucci.com/en/versace-jeans-couture/women/new-collection",
    #"https://eleonorabonucci.com/en/versace_collection/women/sale",
    #"https://www.gebnegozionline.com/it_it/donna/designers/versace-home.html",
    #"https://www.tessabit.com/it_it/donna/designers/versace-jeans-couture.html?page=1",
]

    vip_versace_woman = VersaceVipWoman.new
    @price = VersaceVipWoman.call_price
    @category = VersaceVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/versace?cat=166"
            vip_versace_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/versace"
            vip_versace_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/versace-woman",
            vip_versace_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Versace/"
            vip_versace_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下はselenium
        when "https://www.alducadaosta.com/it/donna/designer/versace"
            vip_versace_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/versace/?category=women"
            vip_versace_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://eleonorabonucci.com/en/versace/women/new-collection"
            vip_versace_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/versace.html"
            vip_versace_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/versace"
            vip_versace_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/versace.html?page=1"
            vip_versace_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/versace.html"
            vip_versace_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end