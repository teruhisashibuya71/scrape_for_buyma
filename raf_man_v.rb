require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class RafVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby raf_man_v.rb
    @category = "服"
    @price = "364"
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
        "https://actuelb.com/en/1954-raf-simons",
        "https://www.coltortiboutique.com/it/designer/raf_simons?cat=151",
        "https://eleonorabonucci.com/en/raf-simons/men"
        "https://nugnes1920.com/collections/raf-simons-man",
        #以下selenium
        "https://www.alducadaosta.com/it/uomo/designer/raf_simons",
        "https://www.minettiangeloonline.com/it/man-raf+simons",
        "https://www.gebnegozionline.com/it_it/uomo/designers/raf-simons.html",
        "https://www.wiseboutique.com/it_it/uomo/designers/raf-simons.html",
        "https://www.blondieshop.com/it/uomo/man-designer/raf-simons.html",
        # 商品0こ "https://www.montiboutique.com/it-IT/uomo/designer/raf_simons"
    ]

    raf_man_vip = RafVipMan.new
    @price = RafVipMan.call_price
    @category = RafVipMan.call_category
    @currency = RafVipMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/1954-raf-simons"
            raf_man_vip.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/it/designer/raf_simons?cat=151"
            raf_man_vip.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/raf-simons/men"
            raf_man_vip.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://nugnes1920.com/collections/raf-simons-man"        
            raf_man_vip.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/raf_simons"
            raf_man_vip.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man-raf+simons" 
            raf_man_vip.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/uomo/man-designer/raf-simons.html"
            raf_man_vip.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/uomo/designers/raf-simons.html"
            raf_man_vip.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/raf_simons"
            raf_man_vip.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/uomo/designers/raf-simons.html"
            raf_man_vip.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end