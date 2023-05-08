
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class GoldenVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby golden_w_v.rb
    @category = "靴"
    @price = "455"
    @currency = 143.8
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
end
ATTACK_LIST_URL = [
    "https://amrstore.com/collections/golden-goose",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?page=1&view=90&sort=3&scale=274&designer=353940",
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?page=1&view=90&sort=3&scale=274&designer=353940",
    "https://www.coltortiboutique.com/it/designer/golden_goose?cat=166",
    "https://eleonorabonucci.com/en/golden_goose/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/golden_goose",
    "https://www.leam.com/it_eu/designer/golden-goose-donna.html",
    "https://nugnes1920.com/collections/golden-goose-deluxe-brand-woman",
    #取り扱い終了 "https://www.russocapri.com/it/tutti/designer/golden-goose/gruppi",
    #sigrun
    "https://suitnegozi.com/collections/golden-goose-deluxe-brand-donna",    
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/golden_goose",
    "https://www.minettiangeloonline.com/it/woman?idt=18",
    "https://www.brunarosso.com/designer/430-golden-goose-woman",
    "https://www.gebnegozionline.com/it_it/donna/designers/golden-goose-deluxe-brand.html",
    "http://specialshop.atelier98.net/it/donna?idt=840000209",
    "https://www.blondieshop.com/it/donna/woman-designer/golden-goose.html"
    
] 
    vip_golden_woman = GoldenVipWoman.new
    @price = GoldenVipWoman.call_price
    @category = GoldenVipWoman.call_category
    @currency = GoldenVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/golden-goose"
            vip_golden_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?page=1&view=90&sort=3&scale=274&designer=353940"
            vip_golden_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=34624"
            vip_golden_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/golden_goose?cat=166"
            vip_golden_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/golden_goose/women" 
            vip_golden_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gebnegozionline.com/it_it/donna/designers/golden-goose-deluxe-brand.html"
            vip_golden_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gaudenziboutique.com/en-it/women/designer/golden_goose"
            vip_golden_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/golden-goose-donna.html"
            vip_golden_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/golden-woman"
            vip_golden_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/tutti/designer/golden-goose/gruppi"
            vip_golden_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        # when ""
        #     vip_golden_woman.sigrun_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "https://suitnegozi.com/collections/golden-goose-deluxe-brand-donna"
            vip_golden_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.alducadaosta.com/it/donna/designer/golden_goose"
            vip_golden_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=18" 
            vip_golden_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/430-golden-goose-woman"
            vip_golden_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category, "GOLDEN")
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/golden-goose.html"
            vip_golden_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=840000209"
            vip_golden_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        end
    end
