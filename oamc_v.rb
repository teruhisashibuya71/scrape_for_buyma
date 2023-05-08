require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class OamcVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby oamc_v.rb
    @category = "靴"
    @price = "550"
    @currency = 147.2
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
        #nokogiri系
        "https://www.coltortiboutique.com/it/designer/oamc"
        "https://suitnegozi.com/collections/oamc-uomo"

        #selenium系サイトのブランド一覧
        "https://www.gebnegozionline.com/it_it/uomo/designers/oamc.html"
    ]

    oamc_v_man = VipMan.new
    @price = VipMan.call_price
    @category = VipMan.call_category
    @currency = VipMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/oamc"
            oamc_v_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/oamc-uomo"
            oamc_v_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.gebnegozionline.com/it_it/uomo/designers/oamc.html    "
            oamc_v_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end
end