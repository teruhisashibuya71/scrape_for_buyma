require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


#require ./ファイル名
require './actuelb'
require './amr'
require './amr_f_man'
require './auzmendi_f_man'
require './coltorti_man'
require './gaudenzi'
require './leam'
require './nugnes'
require './russocapri'
require './suit'
#require './wise_f_man' #monclerは価格違いがあるので

#selenium系
require './alducadaosta'
require './brunarosso_man'
require './blondie'
require './eleonorabonucci'
require './gb_selenium'
require './monti'
require './tessabit'
require './wise'


class GoldenVipMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"
    
    include Actuelb
    include Amr
    include AmrFarfetchMan
    include AuzmendiFarfetchMan
    include ColtortiMan
    include Gaudenzi
    include Leam
    include Nugnes
    include Russocapri
    include Suit
    #include WiseFarfetchMan

    #seleniumm系
    include Alducadaosta
    include BrunarossoMan
    include Blondie
    include Eleonorabonucci
    include Gbselenium
    include Monti
    include Tessabit
    include Wise

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

ATTACK_LIST_URL = [
    "https://amrstore.com/collections/golden-goose",
    "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=353940",
    "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=353940",
    "https://www.coltortiboutique.com/it/designer/golden_goose?cat=151",
    "https://www.leam.com/en/designer/golden-goose-men.html",
    "https://nugnes1920.com/collections/golden-goose-deluxe-brand-man",
    "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=golden-goose",
    "https://suitnegozi.com/collections/golden-goose-deluxe-brand-uomo",
    
    #以下selenium
    "https://www.alducadaosta.com/it/uomo/designer/golden_goose",
    "https://www.brunarosso.com/s/designers/golden-goose/?category=men",
    "https://www.blondieshop.com/jp/man/man-designer/golden-goose.html",
    "https://eleonorabonucci.com/en/golden_goose/men/new-collection",
    "https://eleonorabonucci.com/en/golden_goose/men/sale",
    "https://www.gebnegozionline.com/it_it/uomo/designers/golden-goose-deluxe-brand.html"

]

    vip_golden_man = goldenVipMan.new
    @price = goldennVipMan.call_price
    @category = FendiVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/golden-goose"
            vip_golden_man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=353940"
            vip_golden_man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/men/auzmendi/items.aspx?view=90&scale=282&rootCategory=Men&designer=353940"
            vip_golden_man.auzumendi_f_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/golden_goose?cat=151"
            vip_golden_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/golden-goose-men.html"
            vip_golden_man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/golden-goose-deluxe-brand-man"
            vip_golden_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi?ds=golden-goose"
            vip_golden_man.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when "https://suitnegozi.com/collections/golden-goose-deluxe-brand-uomo"
            vip_golden_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/golden_goose"
        vip_golden_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/golden-goose/?category=men"
            vip_golden_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.blondieshop.com/jp/man/man-designer/golden-goose.html"
            vip_golden_man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/golden_goose/men/new-collection"
            vip_golden_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/golden_goose/men/sale"
            vip_golden_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when ""https://www.gebnegozionline.com/it_it/uomo/designers/golden-goose-deluxe-brand.html"" 
            vip_golden_man.gb_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        end
    end
end