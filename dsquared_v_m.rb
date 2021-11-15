#require 'rubygems'
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


class Dsquard2VipMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "360"
    
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
    "https://actuelb.com/en/157-men-s-dsquared2",
    "https://amrstore.com/collections/dsquared",
    "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=19003",
    "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=19003",
    "https://www.coltortiboutique.com/it/designer/dsquared2?cat=151",
    "https://www.gaudenziboutique.com/en-it/men/designer/dsquared2",
    "https://www.leam.com/en/designer/dsquared2-men.html",
    "https://www.michelefranzesemoda.com/it/uomo/designer/dsquared2/",
    "https://nugnes1920.com/collections/dsquared2-man",
    "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=dsquared2",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/dsquared_2",
    "https://www.brunarosso.com/s/designers/dsquared2/?category=men",
    "https://www.blondieshop.com/it/uomo/man-designer/dsquared2.html",
    "https://eleonorabonucci.com/en/dsquared/men/new-collection",
    "https://eleonorabonucci.com/en/dsquared/men/sale",
    "https://www.gebnegozionline.com/it_it/uomo/designers/dsquared.html",
    "https://www.tessabit.com/it_it/uomo/designers/dsquared2.html?page=1",
    "https://www.wiseboutique.com/it_it/uomo/designers/dsquared2.html"
]

    vip_dsqu_man = Dsquard2VipMan.new
    @price = Dsquard2VipMan.call_price
    @category = Dsquard2VipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/157-men-s-dsquared2"
            vip_dsqu_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/dsquared"
            vip_dsqu_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=19003"
            vip_dsqu_man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=19003"
            vip_dsqu_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/dsquared2?cat=151"
            vip_dsqu_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/dsquared2"
            vip_dsqu_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/dsquared2-men.html"
            vip_dsqu_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/dsquared2/"
            vip_dsqu_man.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://nugnes1920.com/collections/dsquared2-man"
            vip_dsqu_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=dsquared2"
            vip_dsqu_man.russo_crawl(attack_site_url, @price)
            #価格調整無し

        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/dsquared_2"
        vip_dsqu_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/dsquared2/?category=men"
            vip_dsqu_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/it/uomo/man-designer/dsquared2.html"
            vip_dsqu_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/dsquared/men/new-collection"
            vip_dsqu_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #sale品
        #when "https://eleonorabonucci.com/en/dsquared/men/sale"
        #    vip_dsqu_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/dsquared.html",
            vip_dsqu_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/dsquared2.html?page=1"
            vip_dsqu_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/dsquared2.html"
            vip_dsqu_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end