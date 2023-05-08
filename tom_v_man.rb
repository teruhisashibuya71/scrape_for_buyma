require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class TomVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby tom_v_man.rb
    @category = "服"
    @price = "2390"
    @currency = 143.2
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
        "https://eleonorabonucci.com/en/tom_ford/men",
        "https://www.gaudenziboutique.com/en-it/men/designer/tom_ford",
        "https://www.michelefranzesemoda.com/it/uomo/designer/tom-ford/",
        "https://nugnes1920.com/collections/tom-ford-man",
        "https://suitnegozi.com/collections/tom-ford-uomo",

        #selenium
        "https://www.alducadaosta.com/it/uomo/designer/tom_ford",
        "https://www.minettiangeloonline.com/it/man?idt=131",
        #"https://www.brunarosso.com/s/designers/tom-ford/?category=men",
        "https://www.gebnegozionline.com/it_it/uomo/designers/tom-ford.html",
        "https://www.montiboutique.com/it-IT/uomo/designer/tom_ford"
    ]

    tom_v_man = TomVipMan.new
    @price = TomVipMan.call_price
    @category = TomVipMan.call_category
    @currency = TomVipMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://eleonorabonucci.com/en/tom_ford/men"
            tom_v_man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/men/designer/tom_ford"
            tom_v_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.michelefranzesemoda.com/it/uomo/designer/tom-ford/"
            tom_v_man.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when "https://nugnes1920.com/collections/tom-ford-man"
            tom_v_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/tom-ford-uomo"
            tom_v_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/uomo/designer/tom_ford"
            tom_v_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/man?idt=131" 
            tom_v_man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/tom-ford/?category=men"
            tom_v_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when "https://www.gebnegozionline.com/it_it/uomo/designers/tom-ford.html"
            tom_v_man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/tom_ford"
            tom_v_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        end
    end
end