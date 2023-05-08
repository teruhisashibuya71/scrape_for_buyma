require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class RickVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby rick_man_v.rb
    @category = "服"
    @price = "265"
    @currency = 140.6
    @is_dark = false
    @is_martin = false
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
    def self.is_dark
        @is_dark
    end
    def self.is_martin
        @is_martin
    end
    ATTACK_LIST_URL = [
        "https://amrstore.com/collections/rick-owens",
        "https://www.coltortiboutique.com/it/designer/rick_owens?cat=151",
        "https://eleonorabonucci.com/en/rick_owens/men",
        "https://www.gaudenziboutique.com/en-it/men/designer/rick_owens",
        "https://nugnes1920.com/collections/rick-owens-man",
        
        #selenium
        "https://www.alducadaosta.com/it/uomo/designer/rick_owens",
        "https://www.minettiangeloonline.com/it/man?idt=111"
        #"https://www.brunarosso.com/designer/681-rick-owens-man" ブランド自体なくなった
        #"https://www.blondieshop.com/jp/man/man-designer/rick-owens.html" 商品なし
    ]

    if (@is_dark) {
        ATTACK_LIST_URL.push(
            "https://eleonorabonucci.com/en/rick_owens_drkshdw/men",
            #selenium
            "https://www.alducadaosta.com/it/uomo/designer/rick_owens_drkshdw",
            "https://www.minettiangeloonline.com/it/man?idt=465",
            #"https://www.brunarosso.com/designer/682-rick-owens-drkshdw-man" ブランド自体なくなった
            "https://www.blondieshop.com/it/man/man-designer/dark-shadow.html"
        )
    }
    if (@is_martin) {
        ATTACK_LIST_URL.push(
            #"https://www.alducadaosta.com/it/uomo/designer/rick_owens_x_dr_martens"   
        )
    }

    rick_v_man = RickVipMan.new
    @price = RickVipMan.call_price
    @category = RickVipMan.call_category
    @currency = RickVipMan.call_currency
    @is_dark = RickVipMan.call_is_dark
    @is_martin = RickVipMan.call_is_martin

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/rick-owens"
            rick_v_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/it/designer/rick_owens?cat=151"
            rick_v_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/rick_owens/men"
            rick_v_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/men/designer/rick_owens"
            rick_v_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/rick-owens-man"
            rick_v_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/rick_owens"
            rick_v_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=111"
            rick_v_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/jp/man/man-designer/rick-owens.html"
            rick_v_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        
        #以下 darkshadow
        when "https://eleonorabonucci.com/en/rick_owens_drkshdw/men"
            rick_v_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.alducadaosta.com/it/uomo/designer/rick_owens_drkshdw"
            rick_v_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=465"
            rick_v_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #brunarosso なくなった
        when "https://www.blondieshop.com/it/man/man-designer/dark-shadow.html"
            rick_v_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end
end