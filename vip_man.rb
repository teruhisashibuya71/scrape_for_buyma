require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


#require ./ファイル名
require './actuelb'
require './alducadaosta'
require './auzmendi_f_man'
require './amr_f_man'
require './amr_f_man'
require './coltorti'
require './eleonorabonucci_f_man'
require './gaudenzi'
require './gb_f_man'
require './gb_f_man'
require './leam'
require './nugnes'
require './russocapri'
require './sigrun'
require './suit'
require './tessabit'
require './wise_f_man'


#selenium系
require './brunarosso_man'
require './blondie'
#require './eleonorabonucci'
require './gb_selenium'
require './monti'
require './wise'


class StellaVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"
    
    include Actuelb
    include Alducadaosta
    include AuzmendiFarfetchman
    include AuzmendiFarfetchman
    #----------------------
    #include Amr
    #----------------------
    include AmrFarfetchMan
    include AmrFarfetchMan
    include AmrFarfetchman
    include Coltorti
    include EleonorabonucciFarfetchMan
    include EleonorabonucciFarfetchman
    include Gaudenzi
    include GbFarfetchMan
    include GbFarfetchman
    include Leam
    include Nugnes
    include Russocapri
    include SigrunWoehr
    include Suit
    include Tessabit
    include WiseFarfetchMan
    include WiseFarfetchman

    
    #seleniumm系
    include BrunarossoMan
    include Brunarossoman
    include Blondie
    #include Eleonorabonucci
    include Gbselenium
    include Monti
    include Wise

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "actuel",
    "alduca",
    "auzmendi",
    "amr",
    "coltortiboutique",
    ##"eleonorabonucci farfetch",
    "Gaudenzi",
    ##"gb farfetch",
    "leam",
    "nugnes",
    "russo",
    "sigtrun",
    "suit",
    "tessabit",
    ##"wise farfetch",
    
    #以下selenium
    "brunarosso",
    "blondie",
    ##"eleonorabonucci",
    "gb",
    "monti",
    "wise"
]

    vip_stella_man = StellaVipMan.new
    @price = StellaVipManStellaVipMan.call_price
    @category = FendiVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "actuelb" then
            vip_stella_man.actuel_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "alduca" then
            vip_stella_man.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "amr" then
            vip_stella_man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "auzmendi" then
            vip_stella_man.auzumendi_f_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "coltortiboutique" then
            vip_stella_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "eleonorabonucci_farfetch" then
        #     vip_stella_man.elenora_farfetch_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "gaudenzi" then
            vip_stella_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "gb_farfetch" then
        #     vip_stella_man.gbfarfetch_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "leam" then
            vip_stella_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "nagunes" then
            vip_stella_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "russo" then
            vip_stella_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
        # when "sigrun" then
        #     vip_stella_man.sigrun_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "suit" then
            vip_stella_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "tessabit" then
            vip_stella_man.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "wise farfetch" then
            vip_stella_man.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "brunarosso" then
            vip_stella_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "blondie" then
            vip_stella_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "eleonorabonucci" then
            vip_stella_man.elenora_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "gb" then
            vip_stella_man.gb_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "monti" then
            vip_stella_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "wise" then
            moncler_vip_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end



nokogiri系
https://actuelb.com/en/
https://www.alducadaosta.com/it/uomo/designers
https://amrstore.com/collections
https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx
https://www.coltortiboutique.com/it/men-designer
https://www.gaudenziboutique.com/it-IT/uomo/designers
https://www.leam.com/en/designer.html
https://nugnes1920.com/pages/man-designer
https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi




selenium系サイトのブランド一覧
https://www.brunarosso.com/s/designers/?gender=men
https://www.blondieshop.com/it/man/man-designer.html
https://eleonorabonucci.com/en/men/designers
https://www.gebnegozionline.com/it_it/uomo/designers
https://www.montiboutique.com/it-IT/uomo/designers
https://www.wiseboutique.com/it_it/uomo/designers
