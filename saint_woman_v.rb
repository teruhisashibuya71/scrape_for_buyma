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


class SaintVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "アクセ"
    @price = "195"
    
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
    "https://actuelb.com/en/92-women-s-saint-laurent",
    "https://amrstore.com/collections/saint-laurent",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=547344",
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=547344",
    "https://www.coltortiboutique.com/it/designer/saint_laurent?cat=166",
    "https://www.gaudenziboutique.com/en-it/women/designer/saint_laurent",
    "https://www.leam.com/en/designer/saint-laurent-women.html",
    "https://www.michelefranzesemoda.com/it/donna/designer/saint-laurent/",
    "https://nugnes1920.com/collections/saint-laurent-woman",
    "https://www.sigrun-woehr.com/en/By-Brand/Saint-Laurent-Paris/",
    "https://suitnegozi.com/collections/saint-laurent-donna",

    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/saint_laurent",
    "https://www.brunarosso.com/s/designers/saint-laurent/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/saint-laurent.html",
    "https://eleonorabonucci.com/en/saint_laurent/women/new-collection",
    "https://eleonorabonucci.com/en/saint_laurent/women/sale",
    "https://www.gebnegozionline.com/it_it/donna/designers/saint-laurent.html",
    "https://www.montiboutique.com/it-IT/donna/designer/saint_laurent",
    "https://www.tessabit.com/it_it/donna/designers/saint-laurent.html?page=1",
    "https://www.wiseboutique.com/it_it/donna/designers/saint-laurent.html"
]

    vip_saint_woman = SaintVipWoman.new
    @price = SaintVipWoman.call_price
    @category = SaintVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url

        when "https://actuelb.com/en/92-women-s-saint-laurent"
            vip_saint_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/saint-laurent" 
            vip_saint_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=547344"
            vip_saint_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=547344"
            vip_saint_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/saint_laurent?cat=166"
            vip_saint_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/saint_laurent"
            vip_saint_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/saint-laurent-women.html"
            vip_saint_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/donna/designer/saint-laurent/"
            vip_saint_woman.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://nugnes1920.com/collections/saint-laurent-woman"
            vip_saint_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Saint-Laurent-Paris/"
            vip_saint_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/saint-laurent-donna"
            vip_saint_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/saint_laurent" 
            vip_saint_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/saint-laurent/?category=women"
            vip_saint_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/saint-laurent.html"
            vip_saint_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/saint_laurent/women/new-collection"
            vip_saint_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #sale品
        #when "https://eleonorabonucci.com/en/saint_laurent/women/sale"
        #    vip_saint_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/saint-laurent.html"
            vip_saint_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://www.montiboutique.com/it-IT/donna/designer/saint_laurent"
        #    vip_saint_woman.monti_crawl_selenium(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/saint-laurent.html?page=1"
            vip_saint_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/saint-laurent.html"
            vip_saint_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end