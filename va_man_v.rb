require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
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
#require './wise_f_man' #monclerは価格違いがあるので

#selenium系
require './alducadaosta'
require './brunarosso_man'
require './blondie'
require './eleonorabonucci'
require './gb'
require './monti'
require './tessabit'
require './wise'


class ValentinoVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby va_man_v.rb
    @category = "服"
    @price = "450"
    
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
    "https://actuelb.com/en/71-men-s-valentino",
    "https://amrstore.com/collections/valentino",
    "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=10533",
    "https://www.coltortiboutique.com/it/men-designer",
    "https://www.gaudenziboutique.com/en-it/men/designer/valentino",
    #要ログイン "https://www.leam.com/en/designer/valentino-men.html",
    "https://nugnes1920.com/collections/valentino-man",
    "https://suitnegozi.com/collections/valentino-uomo",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/valentino",
    "https://www.brunarosso.com/s/designers/valentino/",
    "https://www.blondieshop.com/it/uomo/man-designer/valentino.html",
    #日本発送不可 "https://www.gebnegozionline.com/it_it/uomo/designers/valentino.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/valentino",
    "https://www.tessabit.com/it_it/uomo/designers/valentino.html?page=1",
    "https://www.wiseboutique.com/it_it/uomo/designers/valentino.html"
]

    vip_valentino_man = ValentinoVipMan.new
    @price = ValentinoVipMan.call_price
    @category = ValentinoVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/71-men-s-valentino"
            vip_valentino_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/valentino"
            vip_valentino_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=10533"
            vip_valentino_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/men-designer",
            vip_valentino_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/valentino"
            vip_valentino_man.gaudenzi_crawl(attack_site_url, @price, @category) 
            @price = @price.delete(".")
        #when #要ログイン "https://www.leam.com/en/designer/valentino-men.html"
        #    vip_valentino_man.leam_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://nugnes1920.com/collections/valentino-man"
            vip_valentino_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/valentino-uomo"
            vip_valentino_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/valentino"
        vip_valentino_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/valentino/"
            vip_valentino_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/valentino.html"
            vip_valentino_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #when #現状日本発送不可 "https://www.gebnegozionline.com/it_it/uomo/designers/valentino.html"
        #    vip_valentino_man.gb_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/valentino"
            vip_valentino_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/valentino.html?page=1"
            vip_valentino_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/valentino.html"
            vip_valentino_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @prizzce.delete(",")
        end
    end
end


#valentinoだけのURL Alducadaostaは40%あるので
# https://www.alducadaosta.com/it/uomo/designer/valentino
# https://www.styleisnow.com/business/designer/valentino?cat=151
# https://www.brunarosso.com/s/designers/valentino/?category=men

# https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=10533
# https://nugnes1920.com/collections/valentino-man
# https://www.wiseboutique.com/it_it/uomo/designers/valentino.html
# https://www.gebnegozionline.com/it_it/uomo/designers/valentino.html
# https://www.leam.com/it_eu/designer/valentino-uomo.html
# https://www.gaudenziboutique.com/en-it/men/designer/valentino
# https://www.tessabit.com/it_it/uomo/designers/valentino.html
# https://www.montiboutique.com/it-IT/Uomo/designer/valentino



# #gravaniだけのURL
# https://www.alducadaosta.com/it/uomo/designer/valentino_garavani
# https://www.styleisnow.com/business/designer/valentino_garavani?cat=151
# https://www.brunarosso.com/s/designers/valentino-garavani/?category=men

# https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?page=1&view=90&sort=3&scale=282&designer=534369
# https://nugnes1920.com/collections/valentino-garavani-man
# https://www.wiseboutique.com/it_it/uomo/designers/valentino-garavani.html
# https://www.gebnegozionline.com/it_it/uomo/designers/valentino-garavani.html
# https://www.leam.com/it_eu/designer/valentino-garavani-uomo.html
# https://www.gaudenziboutique.com/en-it/men/designer/valentino_garavani
# https://www.tessabit.com/it_it/uomo/designers/valentino-garavani.html
# https://www.montiboutique.com/it-IT/Uomo/designer/valentino_garavani




# #服と小物両方のサイト suitは3位とする
# #coltortiboutique
# #buruna
# #alduca
# https://suitnegozi.com/collections/valentino-uomo
# https://actuelb.com/en/71-men-s-valentino
# https://www.blondieshop.com/it/uomo/man-designer/valentino.html?p=2
