#require './ファイル名'
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


#ひとまず完成
class BottegaVipWoman
    
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "890"
    
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

end

ATTACK_LIST_URL = [
    "https://amrstore.com/collections/bottega-veneta",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=19047",
    "https://www.coltortiboutique.com/it/designer/bottega_veneta?cat=166",
    "https://www.gaudenziboutique.com/en-it/women/designer/bottega_veneta",
    "https://www.leam.com/en/designer/bottega-veneta-women.html",
    "https://nugnes1920.com/collections/bottega-veneta-woman",
    "https://www.sigrun-woehr.com/en/By-Brand/Bottega-Veneta/",
    "https://suitnegozi.com/collections/bottega-veneta-donna",

    #selenium
    "https://www.alducadaosta.com/it/donna/designer/bottega_veneta",
    "https://www.brunarosso.com/s/designers/bottega-veneta/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/bottega-veneta.html",
    "https://eleonorabonucci.com/en/bottega-veneta/women/new-collection",
    "https://www.gebnegozionline.com/it_it/donna/designers/bottega-veneta.html",
    "https://www.montiboutique.com/it-IT/donna/designer/bottega_veneta",
    "https://www.tessabit.com/it_it/donna/designers/bottega-veneta.html?page=1"
    ]

    vip_bottega_woman = BottegaVipWoman.new
    @price = BottegaVipWoman.call_price
    @category = BottegaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/bottega-veneta"
            vip_bottega_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=19047"
            vip_bottega_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/bottega_veneta?cat=166"
            vip_bottega_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/bottega_veneta"
            vip_bottega_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/bottega-veneta-women.html"
            vip_bottega_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/bottega-veneta-woman"
            vip_bottega_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Bottega-Veneta/"
            vip_bottega_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/bottega-veneta-donna"
            vip_bottega_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/bottega_veneta"
            vip_bottega_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/bottega-veneta/?category=women"
            vip_bottega_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/bottega-veneta.html"
            vip_bottega_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/bottega-veneta/women/new-collection"
            vip_bottega_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/bottega-veneta.html"
            vip_bottega_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/bottega_veneta"
            vip_bottega_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/bottega-veneta.html?page=1"
            vip_bottega_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
