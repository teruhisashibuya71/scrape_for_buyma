require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


#montiとcoltortiboutiqueがおかしい

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


class MiumiuVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "750"
    
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
    "https://amrstore.com/collections/miu-miu",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=8360",
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=8360",
    "https://www.coltortiboutique.com/it/designer/miu_miu?cat=166",
    "https://www.sigrun-woehr.com/en/By-Brand/Miu-Miu/",
    "https://suitnegozi.com/collections/miu-miu-donna",

    #以下selenium
    "https://www.brunarosso.com/s/designers/miu-miu/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/miu-miu.html",
    "https://www.gebnegozionline.com/it_it/donna/designers/miu-miu.html",
    "https://www.montiboutique.com/it-IT/donna/designer/miu_miu",
    "https://www.tessabit.com/it_it/donna/designers/miu-miu.html?page=1"
]

    vip_miumiu_woman = MiumiuVipWoman.new
    @price = MiumiuVipWoman.call_price
    @category = MiumiuVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/miu-miu"
            vip_miumiu_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=8360"
            vip_miumiu_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=8360"
            vip_miumiu_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/miu_miu?cat=166"
            vip_miumiu_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Miu-Miu/"
            vip_miumiu_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/miu-miu-donna"
            vip_miumiu_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はseleniu系列
        when "https://www.brunarosso.com/s/designers/miu-miu/?category=women"
            vip_miumiu_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/miu-miu.html"
            vip_miumiu_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/miu-miu.html"
            vip_miumiu_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/miu_miu"
            vip_miumiu_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/miu-miu.html?page=1"
            vip_miumiu_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end