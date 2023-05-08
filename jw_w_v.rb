require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class JwVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby jw_w_v.rb
    @category = "靴"
    @price = "545"
    @currency = 148.2
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
    #nokogiri
    #"https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?page=1&view=90&sort=3&scale=274&designer=991",
    #"https://www.coltortiboutique.com/it/designer/j_w_anderson?cat=166",
    #"https://eleonorabonucci.com/en/jw-anderson/women",
    #"https://nugnes1920.com/collections/jw-anderson-woman",
    ##sigrun
#
    ##selenium
    #"https://www.minettiangeloonline.com/it/woman?idt=248",
    "https://www.brunarosso.com/designer/455-jw-anderson-woman",
    #"https://www.gebnegozionline.com/it_it/donna/designers/jw-anderson.html",
    #"https://www.wiseboutique.com/it_it/donna/designers/jw-anderson.html",
    #"https://www.blondieshop.com/it/donna/woman-designer/jw-anderson.html",
    #"https://www.tessabit.com/it_it/donna/designers/jw-anderson.html",
    #"https://www.montiboutique.com/it-IT/donna/designer/j_w_anderson"
]

    vip_jw_woman = JwVipWoman.new
    @price = JwVipWoman.call_price
    @category = JwVipWoman.call_category
    @currency = JwVipWoman.call_currency
    
    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?page=1&view=90&sort=3&scale=274&designer=991" 
            vip_jw_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/j_w_anderson?cat=166"
            vip_jw_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/jw-anderson/women"
            vip_jw_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://nugnes1920.com/collections/jw-anderson-woman"
            vip_jw_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            vip_jw_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下はselenium系列
        when "https://www.minettiangeloonline.com/it/woman?idt=248" 
            vip_jw_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/455-jw-anderson-woman"
            vip_jw_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category, "JW_ANDERSON")
            @price = @price.delete(",") #新サイト以降に伴い調整済み
        when "https://www.blondieshop.com/it/donna/woman-designer/jw-anderson.html"
            vip_jw_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/jw-anderson.html"
            vip_jw_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/j_w_anderson"
            vip_jw_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #oldタイプのため後日調整
        #when "https://www.tessabit.com/it_it/donna/designers/jw-anderson.html"
        #    vip_jw_woman.tessabit_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/jw-anderson.html"
            vip_jw_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end