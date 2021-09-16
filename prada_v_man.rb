require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

#require './ファイル名'
#require './gb'
require './gb_f_man'
require './coltorti'
require './wise_f_man'
require './suit'
require './auzmendi_f_man'
require './amr_f_man'
require './nugnes'


require './monti'
require './blondie'



#ひとまず完成
#

class PradaVipMan

    #include + クラス名
    #include Gb
    include GbFarfetchMan
    include Coltorti
    include WiseFarfetchMan #オリジナルサイトから消えた 検索してもでてこない
    include Suit
    include AuzmendiFarfetchMan
    include AmrFarfetchMan
    include Nugnes
    
    include Monti
    include Blondie

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "アクセ"
    @price = "420"

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.gebnegozionline.com/it_it/uomo/designers/prada.html",
    "https://www.farfetch.com/it/shopping/men/G-B/items.aspx?view=90&scale=282&designer=34624",
    "https://www.coltortiboutique.com/it/designer/prada?cat=151",
    "https://www.farfetch.com/it/shopping/men/wise-boutique/items.aspx?view=90&scale=282&designer=34624",
    "https://suitnegozi.com/collections/prada-uomo",
    "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&designer=34624",
    "https://nugnes1920.com/collections/prada-man",
    "https://www.montiboutique.com/it-IT/Uomo/designer/prada",
    "https://www.blondieshop.com/it/uomo/man-designer/prada.html"
    ]

    vip_prada_man = PradaVipMan.new
    @price = PradaVipMan.call_price
    @category = PradaVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        #when "https://www.gebnegozionline.com/it_it/uomo/designers/prada.html" then
        #    vip_prada_man.gb_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/men/G-B/items.aspx?view=90&scale=282&designer=34624" then
            vip_prada_man.gb_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/prada?cat=151" then
            vip_prada_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/men/wise-boutique/items.aspx?view=90&scale=282&designer=34624" then
            vip_prada_man.wise_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/prada-uomo" then
            vip_prada_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&designer=34624" then
            vip_prada_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/prada-man" then
            vip_prada_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.montiboutique.com/it-IT/Uomo/designer/prada" then
            vip_prada_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/uomo/man-designer/prada.html" then
            vip_prada_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end

    
    
    
    
    
    