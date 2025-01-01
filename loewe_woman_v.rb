require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class LoeweVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby loewe_woman_v.rb
    @category = "バッグ"
    @price = "1750"
    @currency = 
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
    "https://www.coltortiboutique.com/it/designer/loewe?ca_gender=1997",
    "https://www.leam.com/it_eu/designer/loewe-donna.html",
    "https://suitnegozi.com/collections/loewe-donna",
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/loewe",
    #"https://www.brunarosso.com/designer/469-loewe-woman",
    "https://www.gebnegozionline.com/it_it/donna/designers/loewe.html",
    "https://www.blondieshop.com/it/donna/woman-designer/loewe.html",
    "http://specialshop.atelier98.net/it/donna?idt=1980000516",
    "https://www.montiboutique.com/it-IT/donna/designer/loewe" 
    
    #ibiza
    #"https://www.alducadaosta.com/it/donna/designer/loewe_paulas_ibiza",
    #"http://specialshop.atelier98.net/it/donna?idt=840000289"
    #"https://www.departementfeminin.com/en/designers/8-loewe"
]

    vip_loewe_woman = LoeweVipWoman.new
    @price = LoeweVipWoman.call_price
    @category = LoeweVipWoman.call_category
    @currency = LoeweVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/loewe?ca_gender=1997"
            vip_loewe_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/loewe-donna.html"
            vip_loewe_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/loewe-donna"
            vip_loewe_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/loewe"
            vip_loewe_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #要ログイン
        #when "https://www.brunarosso.com/s/designers/?gender=woman"
        #    vip_loewe_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
        #    #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/loewe.html"
            vip_loewe_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/loewe.html"
            vip_loewe_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/loewe"
            vip_loewe_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000516"
            vip_loewe_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応

        #以下はPoul Ibiza
        when "https://www.alducadaosta.com/it/donna/designer/loewe_paulas_ibiza"
            vip_loewe_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=840000289"
            vip_loewe_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        end
    end
end