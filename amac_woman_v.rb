require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class AmacVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby amac_woman_v.rb
    @category = "アクセ"
    @price = "380"
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Gb, Monti, Tessabit, Wise

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

ATTACK_LIST_URL = [
    "https://www.coltortiboutique.com/it/designer/alexander_mcqueen?cat=166",
    "https://eleonorabonucci.com/en/alexander_mcqueen/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/alexander_mcqueen",
    "https://www.michelefranzesemoda.com/it/donna/designer/alexander-mcqueen/",
    "https://nugnes1920.com/collections/alexander-mcqueen-woman",
    "https://www.russocapri.com/it/donna/designer/alexander-mcqueen",
    #"https://www.sigrun-woehr.com/en/By-Brand/Alexander-Mc-Queen/",
    "https://suitnegozi.com/collections/alexander-mcqueen-donna",
    ##以下selenium
    "https://www.alducadaosta.com/it/donna/designer/alexander_mcqueen",
    "https://www.minettiangeloonline.com/it/woman-alexander+mcqueen",
    "https://www.brunarosso.com/s/designers/alexander-mcqueen/?category=women",
    "https://www.gebnegozionline.com/it_it/donna/designers/alexander-mc-queen.html",
    "https://www.tessabit.com/it_it/donna/designers/alexander-mcqueen.html?page=1",
    "https://www.wiseboutique.com/it_it/donna/designers/alexander-mcqueen.html",
    "https://www.montiboutique.com/it-IT/donna/designer/alexander_mcqueen"
]

    vip_amac_woman = AmacVipWoman.new
    @price = AmacVipWoman.call_price
    @category = AmacVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
    
        when "https://www.coltortiboutique.com/it/designer/alexander_mcqueen?cat=166"
            vip_amac_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/alexander_mcqueen/women"
            vip_amac_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/women/designer/alexander_mcqueen"
            vip_amac_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/donna/designer/alexander-mcqueen/"
            vip_amac_woman.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://nugnes1920.com/collections/alexander-mcqueen-woman"
            vip_amac_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/designer/alexander-mcqueen"
            vip_amac_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://www.sigrun-woehr.com/en/By-Brand/Alexander-Mc-Queen/"
            vip_amac_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/alexander-mcqueen-donna"
            vip_amac_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/alexander_mcqueen"
            vip_amac_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman-alexander+mcqueen" 
            vip_amac_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/alexander-mcqueen/?category=women"
            vip_amac_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://eleonorabonucci.com/en/alexander_mcqueen/women/new-collection"
            vip_amac_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/alexander-mc-queen.html"
            vip_amac_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/alexander_mcqueen"
            vip_amac_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/alexander-mcqueen.html?page=1"
            vip_amac_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/alexander-mcqueen.html"
            vip_amac_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end