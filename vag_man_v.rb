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


class ValentinogVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "595"
    
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
    #"https://actuelb.com/en/71-men-s-valentino",
    #"https://amrstore.com/collections/valentino",
    #"https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=534369",
    #"https://www.coltortiboutique.com/it/men-designer",
    #"https://www.gaudenziboutique.com/en-it/men/designer/valentino_garavani",
    ##要ログイン"https://www.leam.com/en/designer/valentino-garavani-men.html",
    #"https://nugnes1920.com/collections/valentino-garavani-man",
    #"https://suitnegozi.com/collections/valentino-uomo",
#
    ##以下selenium
    #"https://www.alducadaosta.com/it/uomo/designer/valentino_garavani",
    #"https://www.brunarosso.com/s/designers/valentino-garavani/?category=men",
    #"https://www.blondieshop.com/it/uomo/man-designer/valentino.html",
    #"https://eleonorabonucci.com/en/valentino/men/sale",
    #現状日本発送不可 "https://www.gebnegozionline.com/it_it/uomo/designers/valentino-garavani.html",
    #"https://www.montiboutique.com/it-IT/uomo/designer/valentino_garavani",
    "https://www.tessabit.com/it_it/uomo/designers/valentino-garavani.html?page=1",
    "https://www.wiseboutique.com/it_it/uomo/designers/valentino-garavani.html"
]

    vip_vag_man = ValentinogVipMan.new
    @price = ValentinogVipMan.call_price
    @category = ValentinogVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/71-men-s-valentino"
            vip_vag_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/valentino"
            vip_vag_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=534369"
            vip_vag_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "https://www.coltortiboutique.com/it/men-designer",
        #    vip_vag_man.coltorti_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/valentino_garavani"
            vip_vag_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when #要ログイン"https://www.leam.com/en/designer/valentino-garavani-men.html"
        #    vip_vag_man.leam_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://nugnes1920.com/collections/valentino-garavani-man"
            vip_vag_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/valentino-uomo"
            vip_vag_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/valentino_garavani"
            vip_vag_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/valentino-garavani/"
            vip_vag_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/valentino.html"
            vip_vag_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
            #saleしかないらしい
        when "https://eleonorabonucci.com/en/valentino/men/sale"
            vip_vag_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://www.gebnegozionline.com/it_it/uomo/designers/valentino-garavani.html" 
        #    vip_vag_man.gb_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/valentino_garavani"
            vip_vag_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/valentino-garavani.html?page=1"
            vip_vag_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/valentino-garavani.html"
            vip_vag_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end


