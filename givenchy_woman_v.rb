require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class GivenchyVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby givenchy_woman_v.rb
    @category = "服"
    @price = "375"
    @currency = 147.2
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWomanFix, Blondie, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end 
    def self.call_price
        @price
    end
    def self.call_currency
        @currency
    end
ATTACK_LIST_URL = [
    #"https://www.coltortiboutique.com/it/designer/givenchy?cat=166",
    "https://eleonorabonucci.com/en/givenchy/women",
    #"https://eleonorabonucci.com/en/givenchy/women/sale",
    "https://www.gaudenziboutique.com/en-it/women/designer/givenchy",
    "https://www.michelefranzesemoda.com/it/donna/designer/givenchy/",
    "https://nugnes1920.com/collections/givenchy-woman",
    "https://www.russocapri.com/it/tutti/designer/givenchy/gruppi",
    "https://suitnegozi.com/collections/givenchy-donna",
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/givenchy",
    "https://www.minettiangeloonline.com/it/woman?idt=10000016",
    "https://www.gebnegozionline.com/it_it/donna/designers/givenchy.html",
    "http://specialshop.atelier98.net/it/donna?idt=10",
    "https://www.wiseboutique.com/it_it/donna/designers/givenchy.html",
    #"https://www.brunarosso.com/s/designers/givenchy/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/givenchy.html"
]
    givenchy_vip_woman = GivenchyVipWoman.new
    @price = GivenchyVipWoman.call_price
    @category = GivenchyVipWoman.call_category
    @currency = GivenchyVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/givenchy?cat=166"
            givenchy_vip_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/givenchy/women"
            givenchy_vip_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/women/designer/givenchy"
            givenchy_vip_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/donna/designer/givenchy/"
            givenchy_vip_woman.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/givenchy-woman"
            givenchy_vip_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/tutti/designer/givenchy/gruppi"
            givenchy_vip_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://suitnegozi.com/collections/givenchy-donna"
            givenchy_vip_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/givenchy"
            givenchy_vip_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=10000016" 
            givenchy_vip_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/givenchy/?category=women"
            givenchy_vip_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/givenchy.html"
            givenchy_vip_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/givenchy/women/new-collection"
            givenchy_vip_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/givenchy.html"
            givenchy_vip_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=10"
            givenchy_vip_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/givenchy.html"
            givenchy_vip_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end