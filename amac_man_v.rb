require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class AmacVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby amac_man_v.rb
    @category = "靴"
    @price = "550"
    @currnecy = 143.5
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoMan, Blondie, Eleonorabonucci, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
    def self.call_currnecy
        @currnecy
    end

ATTACK_LIST_URL = [
    "https://www.residenza725.com/us_en/designers/alexander-mcqueen.html?category_ids=35",
    "https://eleonorabonucci.com/en/alexander_mcqueen/men/new-collection",
    #"https://eleonorabonucci.com/en/alexander_mcqueen/men/sale",
    "https://www.gaudenziboutique.com/en-it/men/designer/alexander_mcqueen",
    "https://www.michelefranzesemoda.com/it/uomo/designer/alexander-mcqueen/",
    "https://nugnes1920.com/collections/alexander-mcqueen-man",
    "https://www.russocapri.com/it/uomo/designer/alexander-mcqueen/gruppi",
    "https://suitnegozi.com/collections/mcqueen-uomo",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/alexander_mcqueen",
    "https://www.minettiangeloonline.com/it/man?idt=10000012",
    "https://www.brunarosso.com/s/designers/alexander-mcqueen/?category=men",
    "https://www.gebnegozionline.com/it_it/uomo/designers/alexander-mc-queen.html",
    "http://specialshop.atelier98.net/it/uomo?idt=1980000921",
    "https://www.wiseboutique.com/it_it/uomo/designers/alexander-mcqueen.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/alexander_mcqueen"
]
    vip_amac_man = AmacVipMan.new
    @price = AmacVipMan.call_price
    @category = AmacVipMan.call_category
    @currency = AmacVipMan.call_currnecy

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/alexander_mcqueen?cat=151"
            vip_amac_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/alexander_mcqueen/men/new-collection"
            vip_amac_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gaudenziboutique.com/en-it/men/designer/alexander_mcqueen"
            vip_amac_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/alexander-mcqueen/"
            vip_amac_man.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/alexander-mcqueen-man"
            vip_amac_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/designer/alexander-mcqueen/gruppi"
            vip_amac_man.russo_crawl(attack_site_url, @price)
            #価格調整無くなった
        when "https://suitnegozi.com/collections/alexander-mcqueen-uomo"
            vip_amac_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/alexander_mcqueen"
            vip_amac_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=10000012"
            vip_amac_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/alexander-mcqueen/?category=men"
            target_brand = "ALEXANDER MCQUEEN"
            vip_amac_man.brunarosso_crawl_selenium(attack_site_url, @price, @category, target_brand)
            #調整不要
        when "https://eleonorabonucci.com/en/alexander_mcqueen/men/sale"
            vip_amac_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/alexander-mc-queen.html"
            vip_amac_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/alexander_mcqueen"
            vip_amac_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo?idt=1980000921"
            vip_amac_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/uomo/designers/alexander-mcqueen.html"
            vip_amac_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end


#スニーカーの割引が大きい順序
#minetti    25%       25€ ハーフあり
#coltorti   15〜20%   29€ ハーフ無いかも
#tessabit   30%       69€ ハーフあり
#alduca     15〜20%   30€ ハーフあり
#suit       20%       49€ ハーフあり
#russo      15%       35€ ハーフあり





