require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class BalenciagaVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby balenciaga_woman_v.rb
    @category = "アクセ"
    @price = "250"
    @currency = 149.2
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
        "https://actuelb.com/en/75-women-s-balenciaga",
        "https://www.coltortiboutique.com/it/designer/balenciaga?ca_gender=1997",
        "https://eleonorabonucci.com/en/balenciaga/women",
        "https://www.gaudenziboutique.com/en-it/women/designer/balenciaga",
        "https://www.leam.com/it_eu/designer/balenciaga-donna.html",
        "https://nugnes1920.com/collections/balenciaga-woman",
        "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=balenciaga",
        #"https://www.sigrun-woehr.com/en/By-Brand/Balenciaga/",
        "https://suitnegozi.com/collections/balenciaga-donna",
        #以下selenium
        "https://www.alducadaosta.com/it/donna/designer/balenciaga",
        "https://www.brunarosso.com/designer/345-balenciaga-woman",
        "https://www.gebnegozionline.com/it_it/donna/designers/balenciaga.html",
        "https://www.blondieshop.com/it/donna/woman-designer/balenciaga.html",
        "http://specialshop.atelier98.net/it/donna?idt=1980000003",
        "https://www.montiboutique.com/it-IT/donna/designer/balenciaga"
    ]

    vip_balenciaga_woman = BalenciagaVipWoman.new
    @price = BalenciagaVipWoman.call_price
    @category = BalenciagaVipWoman.call_category
    @currency = BalenciagaVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/75-women-s-balenciaga"
            vip_balenciaga_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://eleonorabonucci.com/en/balenciaga/women"
            vip_balenciaga_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gaudenziboutique.com/en-it/women/designer/balenciaga"
            vip_balenciaga_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/balenciaga-donna.html"
            vip_balenciaga_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/balenciaga-woman"
            vip_balenciaga_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=balenciaga"
            vip_balenciaga_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://www.sigrun-woehr.com/en/By-Brand/Balenciaga/"
            vip_balenciaga_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/balenciaga-donna"
            vip_balenciaga_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/balenciaga"
            vip_balenciaga_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/345-balenciaga-woman"
            vip_balenciaga_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category, "BALENCIAGA")
            @price = @price.delete(",") #新サイト移行に伴い調整
        when "https://www.blondieshop.com/it/donna/woman-designer/balenciaga.html"
            vip_balenciaga_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/balenciaga.html"
            vip_balenciaga_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/balenciaga"
            vip_balenciaga_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000003"
            vip_balenciaga_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        end
    end
end