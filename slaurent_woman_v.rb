require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class SlVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby slaurent_woman_v.rb
    @category = "バッグ"
    @price = "1150"
    @currency = 140.7
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, BrunarossoWoman, Blondie, Eleonorabonucci, Gb, Monti, Tessabit, Wise
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
    "https://actuelb.com/en/92-women-s-saint-laurent",
    "https://amrstore.com/collections/saint-laurent",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=547344",
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=547344",
    "https://www.coltortiboutique.com/it/designer/saint_laurent?cat=166",
    "https://eleonorabonucci.com/en/saint_laurent/women/new-collection",
    "https://www.gaudenziboutique.com/en-it/women/designer/saint_laurent",
    "https://www.leam.com/en/designer/saint-laurent-women.html",
    "https://www.michelefranzesemoda.com/it/donna/designer/saint-laurent/",
    "https://nugnes1920.com/collections/saint-laurent-woman",
    "https://www.sigrun-woehr.com/en/By-Brand/Saint-Laurent-Paris/",
    "https://suitnegozi.com/collections/saint-laurent-donna",
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/saint_laurent",
    # no item "https://www.minettiangeloonline.com/it/woman?idt=90",
    #"https://www.brunarosso.com/s/designers/saint-laurent/?category=women",
    "https://www.gebnegozionline.com/it_it/donna/designers/saint-laurent.html",
    "https://www.wiseboutique.com/it_it/donna/designers/saint-laurent.html",
    "http://specialshop.atelier98.net/it/donna?idt=1980000006",
    "https://www.blondieshop.com/it/donna/woman-designer.html",
    "https://www.montiboutique.com/it-IT/donna/designer/saint_laurent"
]

    sl_vip__woman = SlVipWoman.new
    @price = SlVipWoman.call_price
    @category = SlVipWoman.call_category
    @currency = SlVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/92-women-s-saint-laurent"
            sl_vip__woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/saint-laurent"
            sl_vip__woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=547344" 
            sl_vip__woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=547344"
            sl_vip__woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/saint_laurent?cat=166"
            sl_vip__woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/saint_laurent/women/new-collection"
            sl_vip__woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/women/designer/saint_laurent"
            sl_vip__woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/saint-laurent-women.html"
            sl_vip__woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/donna/designer/saint-laurent/"
            sl_vip__woman.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/saint-laurent-woman"
            sl_vip__woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://www.sigrun-woehr.com/en/By-Brand/Saint-Laurent-Paris/"
        #    sl_vip__woman.sigrun_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://suitnegozi.com/collections/saint-laurent-donna"
            sl_vip__woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/saint_laurent"
            sl_vip__woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/saint-laurent/?category=women"
            sl_vip__woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer.html"
            sl_vip__woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/saint_laurent/women/new-collection"
            sl_vip__woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/saint-laurent.html"
            sl_vip__woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") 
        when "https://www.montiboutique.com/it-IT/donna/designer/saint_laurent"
            sl_vip__woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000006"
            sl_vip__woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/saint-laurent.html"
            sl_vip__woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end