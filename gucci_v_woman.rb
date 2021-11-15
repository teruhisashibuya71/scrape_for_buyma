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


class GucciVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "1980"
    
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
    "https://amrstore.com/collections/gucci",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=25354",
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=25354",
    "https://www.gaudenziboutique.com/en-it/women/designer/gucci",
    # 要ログイン "https://www.leam.com/en/designer/gucci-women.html",
    "https://nugnes1920.com/collections/gucci-woman",
    "https://www.farfetch.com/it/shopping/women/sigrun-woehr/items.aspx?view=90&scale=274&rootCategory=Women&designer=25354",
    "https://suitnegozi.com/collections/gucci-donna",

    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/gucci",
    "https://www.blondieshop.com/it/donna/woman-designer/gucci.html",
    "https://www.gebnegozionline.com/it_it/donna/designers/gucci.html",
    "https://www.montiboutique.com/it-IT/donna/designer/gucci",
    "https://www.tessabit.com/it_it/donna/designers/gucci.html?page=1",
    "https://www.wiseboutique.com/it_it/donna/designers/gucci.html"
]

    vip_gucci_woman = GucciVipWoman.new
    @price = GucciVipWoman.call_price
    @category = GucciVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        
        when "https://amrstore.com/collections/gucci"
            vip_gucci_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=25354"
            vip_gucci_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=25354"
            vip_gucci_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/gucci"
            vip_gucci_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "https://www.leam.com/en/designer/gucci-women.html"
        #     vip_gucci_woman.leam_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "https://nugnes1920.com/collections/gucci-woman"
            vip_gucci_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://www.farfetch.com/it/shopping/women/sigrun-woehr/items.aspx?view=90&scale=274&rootCategory=Women&designer=25354"
        #    vip_gucci_woman.sigrun_farfetch_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        when "https://suitnegozi.com/collections/gucci-donna"
            vip_gucci_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
    
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/gucci"
            vip_gucci_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/donna/woman-designer/gucci.html"
            vip_gucci_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/gucci.html"
            vip_gucci_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/gucci"
            vip_gucci_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/gucci.html?page=1"
            vip_gucci_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/gucci.html"
            vip_gucci_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end
