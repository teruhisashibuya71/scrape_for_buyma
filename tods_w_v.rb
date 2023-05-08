require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#angelo Eleonora修正済み
class TodsVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby tods_w_v.rb
    @category = "靴"
    @price = "650"
    @currency = 141.1
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Gb, Monti, Tessabit, Wise
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
    "https://actuelb.com/en/93-women-s-tod-s",
    "https://www.coltortiboutique.com/it/designer/tod_s?cat=166",
    "https://eleonorabonucci.com/en/tod_s/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/tods",
    "https://www.leam.com/it_eu/designer/tod-s-donna.html",
    "https://nugnes1920.com/collections/tods-woman",
    #sigrun
    "https://suitnegozi.com/collections/tod-s-donna",
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/tods",
    "https://www.minettiangeloonline.com/it/woman?idt=9",
    "https://www.brunarosso.com/designer/598-tod-s-woman",
    "https://www.gebnegozionline.com/it_it/donna/designers/tod-s.html",
    "https://www.wiseboutique.com/it_it/donna/designers/tod-s.html",
    "http://specialshop.atelier98.net/it/donna?idt=1980000791%7C1980000613",
    "https://www.montiboutique.com/it-IT/donna/designer/tods"
]

    vip_tods_woman = TodsVipWoman.new
    @price = TodsVipWoman.call_price
    @category = TodsVipWoman.call_category
    @currency = TodsVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/93-women-s-tod-s"
            vip_tods_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/it/designer/tod_s?cat=166"
            vip_tods_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/tod_s/women"
            vip_tods_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/women/designer/tods"
            vip_tods_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/tod-s-donna.html"
            vip_tods_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/tods-woman"
            vip_tods_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "oooooo"
            vip_tods_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/tod-s-donna"
            vip_tods_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/tods"
            vip_tods_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=9"
            vip_tods_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/tods/?category=women"
            vip_tods_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.gebnegozionline.com/it_it/donna/designers/tod-s.html"
            vip_tods_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/tods"
            vip_tods_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000791%7C1980000613"
            vip_tods_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/tod-s.html"
            vip_tods_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end