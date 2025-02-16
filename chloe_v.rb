require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class ChloeVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby chloe_v.rb
    @category = "バッグ"
    @price = "550"
    @currency = 146.4
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
    "https://www.coltortiboutique.com/it/designer/zchloe?cat=166",
    "https://www.gaudenziboutique.com/en-it/women/designer/chloe",
    "https://www.russocapri.com/it/tutti/designer/chloe",
    #"https://www.sigrun-woehr.com/en/By-Brand/Chloe/",
    "https://suitnegozi.com/collections/chloe-donna",
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/chloe",

    "https://www.gebnegozionline.com/it_it/donna/designers/chloe.html",
    "http://specialshop.atelier98.net/it/donna?idt=9",
    "https://www.wiseboutique.com/it_it/donna/designers/chloe.html"
    #"https://www.departementfeminin.com/en/designers/67-chloe"
]

    vip_chloe_woman = ChloeVipWoman.new
    @price = ChloeVipWoman.call_price
    @category = ChloeVipWoman.call_category
    @currency = ChloeVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/chloe?cat=166"
            vip_chloe_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/chloe"
            vip_chloe_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when  "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=chloe"
            vip_chloe_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://www.sigrun-woehr.com/en/By-Brand/Chloe/"
            vip_chloe_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/chloe-donna" 
            vip_chloe_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/chloe"
            vip_chloe_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/chloe.html"
            vip_chloe_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=9"
            vip_chloe_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/chloe.html"
            vip_chloe_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end