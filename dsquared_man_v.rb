#require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class Dsquard2VipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby dsquared_man_v.rb
    @category = "服"
    @price = "790"
    @currency = 147.2
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoManFix, Blondie, Gb, Monti, Tessabit, Wise
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
    #なくなった?"https://actuelb.com/en/157-men-s-dsquared2",
    "https://amrstore.com/collections/dsquared",
    "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=19003",
    "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=19003",
    "https://www.coltortiboutique.com/it/designer/dsquared2?cat=151",
    "https://eleonorabonucci.com/en/dsquared/men",
    #"https://eleonorabonucci.com/en/dsquared/men/sale",
    "https://www.gaudenziboutique.com/en-it/men/designer/dsquared2",
    "https://www.leam.com/it_eu/designer/dsquared2-men.html",
    "https://www.michelefranzesemoda.com/it/uomo/designer/dsquared2/",
    "https://nugnes1920.com/collections/dsquared2-man",
    "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=dsquared2",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/dsquared_2",
    "https://www.minettiangeloonline.com/it/man?idt=3",
    "https://www.gebnegozionline.com/it_it/uomo/designers/dsquared.html",
    "https://www.wiseboutique.com/it_it/uomo/designers/dsquared2.html",
    "http://specialshop.atelier98.net/it/uomo?idt=1",
    "https://www.blondieshop.com/it/uomo/man-designer/dsquared2.html",
    #"https://www.brunarosso.com/designer/401-dsquared2-man"
]

    vip_dsqu_man = Dsquard2VipMan.new
    @price = Dsquard2VipMan.call_price
    @category = Dsquard2VipMan.call_category
    @currency = Dsquard2VipMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/157-men-s-dsquared2"
            vip_dsqu_man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://amrstore.com/collections/dsquared"
            vip_dsqu_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=19003"
            vip_dsqu_man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=19003"
            vip_dsqu_man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/dsquared2?cat=151"
            vip_dsqu_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/dsquared/men"
            vip_dsqu_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/men/designer/dsquared2"
            vip_dsqu_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/dsquared2-men.html"
            vip_dsqu_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/dsquared2/"
            vip_dsqu_man.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/dsquared2-man"
            vip_dsqu_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=dsquared2"
            vip_dsqu_man.russo_crawl(attack_site_url, @price)
            #価格調整無し

        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/dsquared_2"
            vip_dsqu_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=3" 
            vip_dsqu_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/401-dsquared2-man"
            vip_dsqu_man.brunarosso_crawl_selenium(attack_site_url, @price, @category, "DSQUARED")
            @price = @price.delete(",") #新サイト以降に伴い調整済み
        when "https://www.blondieshop.com/it/uomo/man-designer/dsquared2.html"
            vip_dsqu_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/dsquared.html"
            vip_dsqu_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo?idt=1" 
            vip_dsqu_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/uomo/designers/dsquared2.html"
            vip_dsqu_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end