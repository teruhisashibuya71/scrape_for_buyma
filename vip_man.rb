require 'rubygems'
require 'nokogiri'
require 'open-uri'
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


class StellaVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"
    
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
    "actuel",
    "amr",
    "amr-f",
    "auzmendi",
    "coltortiboutique",
    "Gaudenzi",
    "leam",
    "michelef",
    "nugnes",
    "russo",
    "suit",
    
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

    vip_stella_man = StellaVipMan.new
    @price = StellaVipMan.call_price
    @category = StellaVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "actuelb"
            vip_stella_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "amr"
            vip_stella_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "amr-farfetch"
            vip_stella_man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "auzmendi"
            vip_stella_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "coltortiboutique"
            vip_stella_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "gaudenzi"
            vip_stella_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "leam"
            vip_stella_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "michelf"
            vip_stella_man.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "nagunes"
            vip_stella_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "russo"
            vip_stella_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "suit"
            vip_stella_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "alduca"
        vip_stella_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
        when "brunarosso"
            vip_stella_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "blondie"
            vip_stella_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "eleonorabonucci"
            vip_stella_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "gb"
            vip_stella_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "monti"
            vip_stella_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "tessabit"
            vip_stella_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "wise"
            vip_stella_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end

nokogiri系
https://actuelb.com/en/
https://amrstore.com/collections
https://www.farfetch.com/it/shopping/men/AMR/items.aspx
https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx
https://www.coltortiboutique.com/it/men-designer
https://www.gaudenziboutique.com/en-it/men/designers
https://www.leam.com/en/designer.html
https://www.michelefranzesemoda.com/it/uomo/designers
https://nugnes1920.com/pages/man-designer
https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi
https://suitnegozi.com/pages/designer-uomo?redirect=true&shippingCountry=IT


selenium系サイトのブランド一覧
https://www.alducadaosta.com/it/uomo/designers
https://www.brunarosso.com/s/designers/?gender=men
https://www.blondieshop.com/it/man/man-designer.html
https://eleonorabonucci.com/en/men/designers
https://www.gebnegozionline.com/it_it/uomo/designers
https://www.montiboutique.com/it-IT/uomo/designers
https://www.tessabit.com/it_it/uomo/designers.html?page=1
https://www.wiseboutique.com/it_it/uomo/designers
