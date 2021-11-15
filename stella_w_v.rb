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


class StellaVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "425"
    
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
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502",
    "https://amrstore.com/collections/stella-mccartney",
    "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166",
    "https://www.leam.com/en/designer/stella-mccartney-women.html",
    "https://nugnes1920.com/collections/stella-mccartney-woman",
    "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney",
    "https://suitnegozi.com/collections/stella-mccartney-donna",
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/stella_mccartney",
    "https://www.brunarosso.com/s/designers/stella-mccartney/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.html",
    "https://eleonorabonucci.com/en/stella_mc_cartney/women/new-collection",
    # sell "https://eleonorabonucci.com/en/stella_mc_cartney/women/sale",
    "https://www.gebnegozionline.com/it_it/donna/designers/stella-mccartney.html",
    "https://www.montiboutique.com/it-IT/donna/designer/stella_mccartney",
    "https://www.tessabit.com/it_it/donna/designers/stella-mccartney.html?page=1",
    "https://www.wiseboutique.com/it_it/donna/designers/stella-mccartney.html"
]

    vip_stella_woman = StellaVipWoman.new
    @price = StellaVipWoman.call_price
    @category = StellaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/stella-mccartney"
            vip_stella_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502"
            vip_stella_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166"
            vip_stella_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/stella-mccartney-women.html"
            vip_stella_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/stella-mccartney-woman"
            vip_stella_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney"
            vip_stella_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://suitnegozi.com/collections/stella-mccartney-donna"
            vip_stella_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/stella_mccartney"
            vip_stella_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/stella-mccartney/"
            vip_stella_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.html"
            vip_stella_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/stella_mc_cartney/women/new-collection"
            vip_stella_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #sell
        #when "https://eleonorabonucci.com/en/stella_mc_cartney/women/sale"
        #    vip_stella_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/stella-mccartney.html"
            vip_stella_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/stella_mccartney"
            vip_stella_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/stella-mccartney.html?page=1"
            vip_stella_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/stella-mccartney.html"
            vip_stella_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end