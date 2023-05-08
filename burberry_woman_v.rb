require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class BurberryVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby
    @category = "靴"
    @price = "590"
    @currency = 
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
    "https://actuelb.com/en/493-women-s-burberry",
    "https://amrstore.com/collections/burberry",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=769627",
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=769627",
    "https://www.coltortiboutique.com/it/designer/burberry?cat=166",
    "https://www.gaudenziboutique.com/en-it/women/designer/burberry",
    "https://www.leam.com/it_eu/designer/burberry-donna.html",
    "https://www.michelefranzesemoda.com/it/donna/designer/burberry/",
    "https://nugnes1920.com/collections/burberry-woman",
    "https://suitnegozi.com/collections/burberry-donna",

    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/burberry",
    ""
    "https://www.brunarosso.com/s/designers/burberry/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/burberry.html",
    "https://www.gebnegozionline.com/it_it/donna/designers/burberry.html",
    "https://www.montiboutique.com/it-IT/donna/designer/burberry",
    "http://specialshop.atelier98.net/it/uomo-burberry",
    "https://www.wiseboutique.com/it_it/donna/designers/burberry.html"
]

    vip_burberry_woman = BurberryVipWoman.new
    @price = BurberryVipWoman.call_price
    @category = BurberryVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/493-women-s-burberry"
            vip_burberry_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/burberry"
            vip_burberry_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=769627"
            vip_burberry_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=769627"
            vip_burberry_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/burberry?cat=166"
            vip_burberry_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/burberry"
            vip_burberry_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/burberry-donna.html"
            vip_burberry_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/donna/designer/burberry/"
            vip_burberry_woman.michele_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://nugnes1920.com/collections/burberry-woman"
            vip_burberry_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/burberry-donna"
            vip_burberry_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/burberry"
            vip_burberry_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.alducadaosta.com/it/donna/designer/burberry"
            vip_burberry_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/burberry.html"
            vip_burberry_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/burberry.html"
            vip_burberry_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/burberry"
            vip_burberry_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo-burberry"
            vip_burberry_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.tessabit.com/it_it/donna/designers/burberry.html?page=1"
            vip_burberry_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/burberry.html"
            vip_burberry_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end