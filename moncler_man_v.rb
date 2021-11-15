require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


require './actuelb'
require './amr'
require './amr_f_man'
require './alducadaosta'
require './auzmendi_f_man'
require './coltorti_man'
require './gb_f_man'
require './gaudenzi'
require './leam'
require './nugnes'
require './russocapri'
require './suit'
require './wise_f_man'

#以下selenium
require './blondie'
require './brunarosso_man'
require './gb'
require './eleonorabonucci'
require './monti'
require './tessabit'
require './wise'


#エラー表示
#→rbuf_fill  wiseでURLにアクセスした時にタイムアウトになった可能性が高い→もう一回クロールすれば大丈夫な事多い

class MonclerVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    @@category = "服"
    @price = "990"

    #クラス名
    include Actuelb
    include Amr
    include AmrFarfetchMan
    include AuzmendiFarfetchMan
    include ColtortiMan
    include Gaudenzi
    include GbFarfetchMan
    include Leam
    include Nugnes
    include Russocapri 
    include Suit
    
    include WiseFarfetchMan

    #以下selenium
    include Alducadaosta
    include Blondie
    include BrunarossoMan
    include Eleonorabonucci
    include Gb
    include Monti
    include Tessabit
    include Wise

    
ATTACK_LIST_URL = [
    "https://actuelb.com/en/66-men-s-moncler",
    "https://amrstore.com/collections/moncler", 
    "https://www.farfetch.com/it/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=4535",
    "https://www.coltortiboutique.com/it/designer/moncler?cat=151",
    "https://www.gaudenziboutique.com/en-it/men/designer/moncler",
    "https://www.leam.com/it_eu/designer/moncler-uomo.html",
    "https://nugnes1920.com/collections/moncler-man",
    "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=moncler",
    "https://suitnegozi.com/collections/moncler-uomo",

    ##以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/moncler",
    "https://www.brunarosso.com/s/designers/moncler/?category=men",
    "https://www.blondieshop.com/it/uomo/man-designer/moncler.html",
    "https://www.gebnegozionline.com/it_it/uomo/designers/moncler.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/moncler",
    "https://www.tessabit.com/en_it/man/designers/moncler.html?page=1",
    "https://www.wiseboutique.com/en_it/uomo/designers/moncler.html"

    ##以下ジーニアス  フラグメント
    #"https://www.coltortiboutique.com/it/designer/7_moncler_frgmt?cat=151",
    #"https://www.coltortiboutique.com/it/uomo/moncler-genius.html",
    #"https://www.gaudenziboutique.com/en-it/men/designer/moncler_genius",
    #"https://www.leam.com/en/men.html?manufacturer=7652_7650_7647_7685_7885_7783",
    #"https://nugnes1920.com/collections/moncler-fragment-man",
    #"https://nugnes1920.com/collections/moncler-genius-1952-man",
    #"https://suitnegozi.com/collections/moncler-1952-uomo",
    #
    ##以下グルノーブル
    #"https://www.gaudenziboutique.com/en-it/men/designer/moncler_grenoble",
    #"https://www.leam.com/en/designer/moncler-grenoble-men.html",
    #"https://nugnes1920.com/collections/moncler-grenoble-man",
    #"https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=moncler-grenoble"

    ]


    moncler_vip_man = MonclerVipMan.new
    
    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/66-men-s-moncler" then
            moncler_vip_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/moncler" then
            moncler_vip_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        #amrのfarfetchには商品無し
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&designer=4535" then
            moncler_vip_man.auzmendi_farfetch_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=151" then
            moncler_vip_man.coltorti_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/moncler" then
            moncler_vip_man.gaudenzi_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/moncler-uomo.html" then
            moncler_vip_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/fendi-man" then
            moncler_vip_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/tutti/designer/moncler/gruppi" then
            moncler_vip_man.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/moncler-uomo" then
            moncler_vip_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/moncler" then
            moncler_vip_man.alducadaosta_crawl_selenium(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/moncler/?category=men" then
            moncler_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @@category)
            #商品桁数はいじらない    
        when "https://www.blondieshop.com/it/uomo/man-designer/moncler.html" then
            moncler_vip_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/en_it/uomo/designers/moncler.html" then
            moncler_vip_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/moncler" then
            moncler_vip_man.monti_crawl_selenium(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/en_it/man/designers/moncler.html?page=1" then
            moncler_vip_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")   
        when "https://www.wiseboutique.com/en_it/uomo/designers/moncler.html" then
            moncler_vip_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")

        
        ##以下ジーニアスとフラグメント
        #when "https://www.coltortiboutique.com/it/designer/7_moncler_frgmt?cat=151"
        #    moncler_vip_man.coltorti_crawl(attack_site_url, @price, @@category)
        #    @price = @price.delete(".")
        #when "https://www.coltortiboutique.com/it/uomo/moncler-genius.html"
        #    moncler_vip_man.coltorti_crawl(attack_site_url, @price, @@category)
        #    @price = @price.delete(".")
        #when "https://www.gaudenziboutique.com/en-it/men/designer/moncler_genius"
        #    moncler_vip_man.gaudenzi_crawl(attack_site_url, @price, @@category)
        #    @price = @price.delete(".")
        #when "https://www.leam.com/en/men.html?manufacturer=7652_7650_7647_7685_7885_7783"
        #    moncler_vip_man.leam_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #when "https://nugnes1920.com/collections/moncler-fragment-man"
        #    moncler_vip_man.nugnes_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #when "https://nugnes1920.com/collections/moncler-genius-1952-man"
        #    moncler_vip_man.nugnes_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #when "https://suitnegozi.com/collections/moncler-1952-uomo"
        #    moncler_vip_man.suit_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        

        ##以下グルノーブル
        #when "https://www.gaudenziboutique.com/en-it/men/designer/moncler_grenoble"
        #    moncler_vip_man.gaudenzi_crawl(attack_site_url, @price, @@category)
        #    @price = @price.delete(".")
        #when "https://www.leam.com/en/designer/moncler-grenoble-men.html"
        #    moncler_vip_man.leam_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #when "https://nugnes1920.com/collections/moncler-grenoble-man"
        #    moncler_vip_man.nugnes_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #when "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=moncler-grenoble"
        #    moncler_vip_man.russo_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        end
    end
end