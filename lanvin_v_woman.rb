require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#angelo Eleonora修正済み
class LanvinVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby lanvin_v_woman.rb
    @category = "バッグ"
    @price = "1090"
    @currency = 148.3
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
    #nokogiri系
    "https://amrstore.com/collections/lanvin-1",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?page=1&view=90&sort=3&scale=274&designer=5757",
    "https://www.coltortiboutique.com/it/designer/lanvin?ca_gender=1997",
    "https://eleonorabonucci.com/en/lanvin/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/lanvin",
    "https://nugnes1920.com/collections/lanvin-paris-woman",
    "https://www.alducadaosta.com/it/donna/designer/lanvin_paris",
    #selenium系サイトのブランド一覧
    "https://www.alducadaosta.com/it/donna/designer/lanvin_paris",
    "https://www.minettiangeloonline.com/it/woman?idt=20",
    #"https://www.brunarosso.com/designer/462-lanvin-woman",
    "https://www.gebnegozionline.com/en_it/women/designers/lanvin.html?___from_store=it_it&___from_store=it_it",
    "http://specialshop.atelier98.net/it/donna?idt=1980000089",
    "https://www.wiseboutique.com/en_it/donna/designers/lanvin.html?___from_store=it_it&___from_store=it_it",
    "https://www.blondieshop.com/jp/woman/woman-designer/lanvin.html",
    "https://www.montiboutique.com/it-IT/donna/designer/lanvin"
]
    vip_lanvin_woman = LanvinVipWoman.new
    @price = LanvinVipWoman.call_price
    @category = LanvinVipWoman.call_category
    @currency = LanvinVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/lanvin-1"
            vip_lanvin_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?page=1&view=90&sort=3&scale=274&designer=5757"
            vip_lanvin_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/lanvin?ca_gender=1997"
            vip_lanvin_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/lanvin/women"
            vip_lanvin_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/women/designer/lanvin"
            vip_lanvin_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/lanvin-paris-woman"
            vip_lanvin_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
            #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/lanvin_paris"
            vip_lanvin_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=20"
            vip_lanvin_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/462-lanvin-woman"
            vip_lanvin_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/jp/woman/woman-designer/lanvin.html"
            vip_lanvin_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/en_it/women/designers/lanvin.html?___from_store=it_it&___from_store=it_it"
            vip_lanvin_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/lanvin"
            vip_lanvin_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000089"
            vip_lanvin_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/en_it/donna/designers/lanvin.html?___from_store=it_it&___from_store=it_it"
            vip_lanvin_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end