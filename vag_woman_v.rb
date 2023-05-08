require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class VagVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby vag_woman_v.rb
    @category = "靴"
    @price = "950"
    @currency = 
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
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?page=1&view=90&sort=3&scale=274&designer=534369",
    "https://www.coltortiboutique.com/it/designer/valentino_garavani?cat=166",
    "https://www.gaudenziboutique.com/en-it/women/designer/valentino_garavani", #garabvaniに服も統一された
    "https://www.leam.com/it_eu/designer/valentino-garavani-donna.html",
    "https://nugnes1920.com/collections/valentino-garavani-woman",
    #"https://www.sigrun-woehr.com/en/By-Brand/Valentino/",
    "https://suitnegozi.com/collections/valentino-donna",
    #slenium系
    "https://www.alducadaosta.com/it/donna/designer/valentino_garavani",
    "https://www.minettiangeloonline.com/it/woman?idt=442",
    "https://www.gebnegozionline.com/it_it/donna/designers/valentino-garavani.html",
    "https://www.wiseboutique.com/it_it/donna/designers/valentino-garavani.html",
    "http://specialshop.atelier98.net/it/donna?idt=1980000153",
    "https://www.blondieshop.com/it/donna/woman-designer/valentino.html",
    "https://www.montiboutique.com/it-IT/Donna/designer/valentino_garavani",
]

    vag_v_woman = VagVipWoman.new
    @price = VagVipWoman.call_price
    @category = VagVipWoman.call_category
    @currency = VagVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?page=1&view=90&sort=3&scale=274&designer=534369"
            vag_v_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/valentino_garavani?cat=166"
            vag_v_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/valentino_garavani"
            vag_v_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/valentino-garavani-donna.html"
            vag_v_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/valentino-garavani-woman"
            vag_v_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Valentino/"
            vag_v_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/valentino-donna"
            vag_v_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/valentino_garavani"
            vag_v_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=442" 
            vag_v_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/donna/woman-designer/valentino.html"
            vag_v_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/valentino-garavani.html"
            vag_v_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/valentino_garavani"
            vag_v_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000153"
            vag_v_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/valentino-garavani.html"
            vag_v_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end

#nokogiri系
#https://actuelb.com/en/
#https://amrstore.com/collections
#https://www.farfetch.com/it/shopping/women/AMR/items.aspx
#https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx
#https://www.coltortiboutique.com/it/women-designer
#https://www.gaudenziboutique.com/en-it/women/designers
#https://www.leam.com/it_eu/designer.html
#https://www.michelefranzesemoda.com/it/donna/designers
#https://nugnes1920.com/pages/woman-designer
#https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi
#https://www.sigrun-woehr.com/en/BRANDS/
#https://suitnegozi.com/pages/designer-donna?redirect=true&shippingCountry=IT
#
#
#
#selenium系サイトのブランド一覧
#https://www.alducadaosta.com/it/donna/designers
#https://www.brunarosso.com/s/designers/?gender=woman
#https://www.blondieshop.com/it/donna/woman-designer.html
#https://eleonorabonucci.com/en/woman/designers
#https://www.gebnegozionline.com/it_it/donna/designers
#https://www.montiboutique.com/it-IT/donna/designers
#https://www.tessabit.com/it_it/donna/designers.html?page=1
#https://www.wiseboutique.com/it_it/donna/designers