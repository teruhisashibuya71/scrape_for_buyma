require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class JimmyVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby jimmy_w_v.rb
    @category = "靴"
    @price = "695"
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
    "https://www.coltortiboutique.com/it/designer/jimmy_choo?cat=166",
    "https://eleonorabonucci.com/en/jimmy_choo/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/jimmy_choo",
    "https://www.leam.com/it_eu/designer/jimmy-choo-donna.html",
    "https://nugnes1920.com/collections/jimmy-choo-woman",
    # sigrun
    "https://suitnegozi.com/collections/jimmy-choo-donna",
    
    #以下selenium
    "https://www.alducadaosta.com/jp/women/designer/jimmy_choo",
    "https://www.minettiangeloonline.com/it/woman-jimmy+choo",
    #burunarosso
    "https://www.gebnegozionline.com/it_it/donna/designers/jimmy-choo.html",
    "http://specialshop.atelier98.net/it/donna?idt=1980000470",
    "https://www.wiseboutique.com/it_it/donna/designers/jimmy-choo.html",
    "https://www.montiboutique.com/it-IT/donna/designer/jimmy_choo"
]
    vip_jimmy_woman = JimmyVipWoman.new
    @price = JimmyVipWoman.call_price
    @category = JimmyVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/jimmy_choo?cat=166"
            vip_jimmy_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/jimmy_choo/women"
            vip_jimmy_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gaudenziboutique.com/en-it/women/designer/jimmy_choo"
            vip_jimmy_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/jimmy-choo-donna.html"
            vip_jimmy_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/jimmy-choo-woman"
            vip_jimmy_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            vip_jimmy_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/jimmy-choo-donna"
            vip_jimmy_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/jp/women/designer/jimmy_choo"
            vip_jimmy_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/jimmy-choo/?category=women"
            vip_jimmy_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.gebnegozionline.com/it_it/donna/designers/jimmy-choo.html"
            vip_jimmy_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/jimmy_choo"
            vip_jimmy_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000470"
            vip_jimmy_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/jimmy-choo.html"
            vip_jimmy_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end