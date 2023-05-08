require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'


class FendiVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby fendi_woman_v.rb
    @category = "靴"
    @price = "890"
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
    ATTACK_LIST_URL = [
        "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=15514",
        "https://www.coltortiboutique.com/it/designer/fendi?cat=166",
        "https://www.gaudenziboutique.com/en-IT/women/designer/fendi",
        "https://nugnes1920.com/collections/fendi-woman",
        #"https://www.sigrun-woehr.com/en/By-Brand/Fendi/",
        "https://suitnegozi.com/collections/fendi-donna",    
        #selenium
        "https://www.alducadaosta.com/it/donna/designer/fendi",
        "https://www.minettiangeloonline.com/it/woman?idt=35",
        "https://www.brunarosso.com/s/designers/fendi/?category=women",
        "https://www.gebnegozionline.com/it_it/donna/designers/fendi.html",
        "https://www.montiboutique.com/it-IT/donna/designer/fendi",
        "https://www.tessabit.com/it_it/donna/designers/fendi.html?page=1",
        "https://www.wiseboutique.com/it_it/donna/designers/fendi.html"
    ]

    vip_fendi_woman = FendiVipWoman.new
    @price = FendiVipWoman.call_price
    @category = FendiVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=15514" 
            vip_fendi_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/fendi/women"
            vip__woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=166" 
            vip_fendi_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-IT/women/designer/fendi" 
            vip_fendi_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/fendi-woman" 
            vip_fendi_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Fendi/" 
            vip_fendi_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/fendi-donna" 
            vip_fendi_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #seleniium
        when "https://www.alducadaosta.com/it/donna/designer/fendi" 
            vip_fendi_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=35" 
            vip__woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/fendi/?category=women" 
            vip_fendi_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.gebnegozionline.com/it_it/donna/designers/fendi.html" 
            vip_fendi_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when  "https://www.montiboutique.com/it-IT/donna/designer/fendi" 
            vip_fendi_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/fendi.html?page=1" 
            vip_fendi_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/fendi.html" 
            vip_fendi_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end
