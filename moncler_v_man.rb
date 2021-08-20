require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

require './alducadaosta'
require './suit'
#require './brunarosso_f_man'
require './tessabit'
require './coltorti'
require './leam'
require './gb'
require './nugnes'
require './blondie'
require './gaudenzi'
require './russocapri'
require './auzmendi_f_man'
require './actuelb'
require './monti'
require './brunarosso_man'
#require './wise'



#gaudenzi修正
class MonclerVipMan

    #クラス名
    include Alducadaosta
    include Suit
    #include BrunarossoFarfetchMan farfetchにない
    include Tessabit
    include Gaudenzi
    include Gb
    include Coltorti
    include Leam
    include Nugnes
    include Blondie
    include Russocapri
    include AuzmendiFarfetchMan
    include Actuelb
    include Gaudenzi
    include Monti
    include BrunarossoMan
    #include Wise
    #include Monti farfetchにない
    #include blondie farfetchにない

    #harreso→ここは無理
    
    #cortessi

    ATTACK_LIST_URL = [
    #"https://www.gebnegozionline.com/it_it/uomo/designers/moncler.html",
    #"https://www.alducadaosta.com/it/uomo/designer/moncler",
    #"https://suitnegozi.com/collections/moncler-uomo",
    #"https://www.tessabit.com/it/uomo/designers/moncler",
    #"https://www.coltortiboutique.com/it/designer/moncler?cat=151",
    #"https://www.leam.com/it_eu/designer/moncler-uomo.html",
    #"https://nugnes1920.com/collections/prada-man",
    #"https://www.russocapri.com/it/tutti/designer/moncler/gruppi",
    #"https://www.gaudenziboutique.com/it-IT/uomo/designer/givenchy",
    #"https://nugnes1920.com/collections/moncler-man",
    #"https://www.blondieshop.com/it/uomo/man-designer/moncler.html",
    #"https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&designer=4535",
    #"https://actuelb.com/en/66-men-s-moncler",
    #"https://www.gaudenziboutique.com/it-IT/uomo/designer/moncler",
    #"https://www.montiboutique.com/it-IT/uomo/designer/moncler",
    "https://www.brunarosso.com/s/designers/moncler/?category=men"
    #wise
    ]

    #服 靴 バッグ アクセ の4種類で対応する
    @@category = "服"
    @price = "1175"

    # def self.call_price
    #     @price
    # end

    moncler_vip_man = MonclerVipMan.new

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.gebnegozionline.com/it_it/uomo/designers/moncler.html" then
            moncler_vip_man.gb_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.alducadaosta.com/it/uomo/designer/moncler" then
            moncler_vip_man.alducadaosta_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/moncler-uomo" then
            moncler_vip_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/uomo/designers/Fendi" then
            moncler_vip_man.tessabit_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=151" then
            moncler_vip_man.coltorti_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/moncler-uomo.html" then
            moncler_vip_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/fendi-man" then
            moncler_vip_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/uomo/man-designer/moncler.html" then
            moncler_vip_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/tutti/designer/moncler/gruppi" then
            moncler_vip_man.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/it-IT/uomo/designer/fendi" then
            moncler_vip_man.gaudenzi_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&designer=4535" then
            moncler_vip_man.auzmendi_farfetch_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://actuelb.com/en/66-men-s-moncler" then
            moncler_vip_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gaudenziboutique.com/it-IT/uomo/designer/moncler" then
            moncler_vip_man.gaudenzi_crawl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/moncler" then
            moncler_vip_man.monti_crawl_selenium(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/moncler/?category=men" then
            moncler_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @@category)
            #商品桁数はいじらない
            puts @price
        end
    end
end
