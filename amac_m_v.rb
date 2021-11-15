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


class AmacVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "430"
    
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
    "https://www.coltortiboutique.com/it/designer/alexander_mcqueen?cat=151",
    "https://www.gaudenziboutique.com/en-it/men/designer/alexander_mcqueen",
    "https://www.michelefranzesemoda.com/it/uomo/designer/alexander-mcqueen/",
    "https://nugnes1920.com/collections/alexander-mcqueen-man",
    "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=alexander-mcqueen",
    "https://suitnegozi.com/collections/alexander-mcqueen-uomo",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/alexander_mcqueen",
    "https://www.brunarosso.com/s/designers/alexander-mcqueen/?category=men",
    "https://eleonorabonucci.com/en/alexander_mcqueen/men/new-collection",
    #"https://eleonorabonucci.com/en/alexander_mcqueen/men/sale",
    "https://www.gebnegozionline.com/it_it/uomo/designers/alexander-mc-queen.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/alexander_mcqueen",
    # 消えた"https://www.tessabit.com/it_it/uomo/designers/alexander-mcqueen.html?page=1",
    "https://www.wiseboutique.com/it_it/uomo/designers/alexander-mcqueen.html"
]

    vip_amac_man = AmacVipMan.new
    @price = AmacVipMan.call_price
    @category = AmacVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/alexander_mcqueen?cat=151"
            vip_amac_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/men/designer/alexander_mcqueen"
            vip_amac_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/alexander-mcqueen/"
            vip_amac_man.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://nugnes1920.com/collections/alexander-mcqueen-man"
            vip_amac_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=alexander-mcqueen"
            vip_amac_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://suitnegozi.com/collections/alexander-mcqueen-uomo"
            vip_amac_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/alexander_mcqueen"
            vip_amac_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/alexander-mcqueen/?category=men"
            vip_amac_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://eleonorabonucci.com/en/alexander_mcqueen/men/new-collection"
            vip_amac_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/alexander_mcqueen/men/sale"
            vip_amac_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/alexander-mc-queen.html"
            vip_amac_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/alexander_mcqueen"
            vip_amac_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/uomo/designers/alexander-mcqueen.html?page=1"
            vip_amac_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/alexander-mcqueen.html"
            vip_amac_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end