require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#brunarosso改修済み
class PalmVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby palm_v.rb
    @category = "服"
    @price = "695"
    @currency = 147.4
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
    "https://amrstore.com/collections/palm-angels",
    #"https://www.farfetch.com/it/shopping/men/AMR/items.aspx?page=1&view=90&sort=3&scale=282&designer=2186014",
    "https://www.coltortiboutique.com/it/designer/palm_angels?cat=151",
    "https://eleonorabonucci.com/en/palm_angels/men",
    #"https://eleonorabonucci.com/en/palm_angels/men/sale",
    "https://www.gaudenziboutique.com/en-it/men/designer/palm_angels",
    "https://www.leam.com/it_eu/designer/palm-angels-uomo.html",
    "https://www.michelefranzesemoda.com/it/uomo/designer/palm-angels/",
    "https://nugnes1920.com/collections/palm-angels-man",
    "https://www.russocapri.com/it/uomo/designer/palm-angels/gruppi",
    "https://suitnegozi.com/collections/palm-angels-uomo",
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/palm_angels",
    "https://www.minettiangeloonline.com/it/man?idt=147",
    "https://www.brunarosso.com/designer/522-palm-angels-man",
    "https://www.gebnegozionline.com/it_it/uomo/designers/palm-angels.html",
    "https://www.wiseboutique.com/it_it/uomo/designers/palm-angels.html",
    "http://specialshop.atelier98.net/it/uomo?idt=1980000474",
    "https://www.blondieshop.com/it/uomo/man-designer/palm-angels.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/palm_angels"
]

    palm_vip_man = PalmVipMan.new
    @price = PalmVipMan.call_price
    @category = PalmVipMan.call_category
    @currency = PalmVipMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/palm-angels"
            palm_vip_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?page=1&view=90&sort=3&scale=282&designer=2186014"
            palm_vip_man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/palm_angels?cat=151"
            palm_vip_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/palm_angels/men"
            palm_vip_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/men/designer/palm_angels"
            palm_vip_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/palm-angels-uomo.html"
            palm_vip_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/palm-angels/"
            palm_vip_man.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/palm-angels-man"
            palm_vip_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/designer/palm-angels/gruppi"
            palm_vip_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://suitnegozi.com/collections/palm-angels-uomo"
            palm_vip_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/palm_angels"
            palm_vip_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=147" 
            palm_vip_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/522-palm-angels-man"
            palm_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category, "PALM_ANGELS")
            @price = @price.delete(",") #新サイト移行に伴い調整
        when "https://www.blondieshop.com/it/uomo/man-designer/palm-angels.html"
            palm_vip_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/palm-angels.html"
            palm_vip_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/palm_angels"
            palm_vip_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/uomo?idt=1980000474"
            palm_vip_man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/uomo/designers/palm-angels.html"
            palm_vip_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end