require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class StellaVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby stella_woman_v.rb
    @category = "バッグ"
    @price = "950"
    @currency = 149.9
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
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502",
    "https://eleonorabonucci.com/en/stella_mc_cartney/women",
    # sell "https://eleonorabonucci.com/en/stella_mc_cartney/women/sale",
    "https://amrstore.com/collections/stella-mccartney",
    "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166",
    "https://www.leam.com/en/designer/stella-mccartney-women.html",
    "https://nugnes1920.com/collections/stella-mccartney-woman",
    "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney",
    "https://suitnegozi.com/collections/stella-mccartney-donna",
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/stella_mccartney",
    "https://www.minettiangeloonline.com/it/woman?idt=234",
    "https://www.brunarosso.com/designer/583-stella-mccartney-woman",
    "https://www.gebnegozionline.com/it_it/donna/designers/stella-mccartney.html",
    "https://www.wiseboutique.com/it_it/donna/designers/stella-mccartney.html",
    "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.html",
    "http://specialshop.atelier98.net/it/donna?idt=2",
    "https://www.montiboutique.com/it-IT/donna/designer/stella_mccartney"
]

    vip_stella_woman = StellaVipWoman.new
    @price = StellaVipWoman.call_price
    @category = StellaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/stella-mccartney"
            vip_stella_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502"
            vip_stella_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166"
            vip_stella_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
            #sellもある
        when "https://eleonorabonucci.com/en/stella_mc_cartney/women"
            vip_stella_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.leam.com/en/designer/stella-mccartney-women.html"
            vip_stella_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/stella-mccartney-woman"
            vip_stella_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney"
            vip_stella_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://suitnegozi.com/collections/stella-mccartney-donna"
            vip_stella_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/stella_mccartney"
            vip_stella_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=234" 
            vip_stella_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/583-stella-mccartney-woman"
            vip_stella_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category, "STELLA")
            @price = @price.delete(",") #新サイト以降に伴い調整済み
        when "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.html"
            vip_stella_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/stella_mc_cartney/women/new-collection"
            vip_stella_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/stella-mccartney.html"
            vip_stella_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/stella_mccartney"
            vip_stella_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=2"
            vip_stella_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/stella-mccartney.html"
            vip_stella_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end