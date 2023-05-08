require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class JimmyVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby jimmy_man_v.rb
    @category = "バッグ"
    @price = "595"
    @currency = 147.8
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoMan, Blondie, Gb, Monti, Tessabit, Wise
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
    "https://www.coltortiboutique.com/it/designer/jimmy_choo?ca_gender=1996",

    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/jimmy_choo",
    "https://www.brunarosso.com/designer/453-jimmy-choo-man",
    "https://www.gebnegozionline.com/it_it/uomo/designers/jimmy-choo.html",
    #商品数0こ  "http://specialshop.atelier98.net/it/uomo?idt=1980000470",
    "https://www.wiseboutique.com/it_it/uomo/designers/jimmy-choo.html",
]

    jimmy_vip_man = JimmyVipMan.new
    @price = JimmyVipMan.call_price
    @category = JimmyVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/jimmy_choo?ca_gender=1996"
            jimmy_vip_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")

            #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/jimmy_choo"
            jimmy_vip_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/jimmy-choo.html"
            jimmy_vip_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
         #when "http://specialshop.atelier98.net/it/uomo?idt=1980000470"
         #    jimmy_vip_man.tessabit_crawl_selenium(attack_site_url, @price)
         #    @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://vip.brunarosso.com/s/designers/jimmy-choo/?category=men"
            jimmy_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category, "JIMMY_CHOO")
            @price = @price.delete(",") #新サイト移行に伴い調整
        when "https://www.wiseboutique.com/it_it/uomo/designers/jimmy-choo.html"
            jimmy_vip_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end