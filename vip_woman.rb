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


class OOOVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"
    
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
    
    https://amrstore.com/collections/miu-miu
    https://www.farfetch.com/it/shopping/women/AMR/items.aspx?page=2&view=90&scale=274&rootCategory=Women&designer=8360
    https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=8360
    https://www.coltortiboutique.com/it/designer/miu_miu?cat=166
    https://www.sigrun-woehr.com/en/By-Brand/Miu-Miu/
    https://suitnegozi.com/collections/miu-miu-donna

    
    #以下selenium
    "alduca",
    "brunarosso",
    "blondie",
    "eleonorabonucci",
    "gb",
    "monti",
    "tessabit",  
    "wise"
]

    vip_stella_woman = OOOVipWoman.new
    @price = OOOVipWoman.call_price
    @category = OOOVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "actuelb" 
            vip_stella_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "amr" 
            vip_stella_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "amr-farfetch" 
            vip_stella_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "auzmendi" 
            vip_stella_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "coltortiboutique" 
            vip_stella_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "gaudenzi" 
            vip_stella_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "leam" 
            vip_stella_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "michelf"
            vip_stella_woman.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "nagunes" 
            vip_stella_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "russo" 
            vip_stella_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "sigrun" 
            vip_stella_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "suit" 
            vip_stella_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "alduca" 
            vip_stella_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "brunarosso" 
            vip_stella_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "blondie" 
            vip_stella_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "eleonorabonucci" 
            vip_stella_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "gb" 
            vip_stella_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "monti" 
            vip_stella_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "tessabit" 
            vip_stella_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "wise" 
            vip_stella_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end

nokogiri系
https://actuelb.com/en/
https://amrstore.com/collections
https://www.farfetch.com/it/shopping/women/AMR/items.aspx
https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx
https://www.coltortiboutique.com/it/women-designer
https://www.gaudenziboutique.com/en-it/women/designers
https://www.leam.com/en/designer.html
https://www.michelefranzesemoda.com/it/donna/designers
https://nugnes1920.com/pages/woman-designer
https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi
https://www.sigrun-woehr.com/en/BRANDS/
https://suitnegozi.com/pages/designer-donna?redirect=true&shippingCountry=IT



selenium系サイトのブランド一覧
https://www.alducadaosta.com/it/donna/designers
https://www.brunarosso.com/s/designers/?gender=woman
https://www.blondieshop.com/it/donna/woman-designer.html
https://eleonorabonucci.com/en/woman/designers
https://www.gebnegozionline.com/it_it/donna/designers
https://www.montiboutique.com/it-IT/donna/designers
https://www.tessabit.com/it_it/donna/designers.html?page=1
https://www.wiseboutique.com/it_it/donna/designers
