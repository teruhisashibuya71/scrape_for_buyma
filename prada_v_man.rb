require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require './alducadaosta'
require './suit'
require './tessabit'
require './coltorti'
require './gb_f_woman'
require './brunarosso'
require './nugnes'
require './gaudenzi'
require './wise'


#require 'selenium-webdriver'
#montiだけあとで https://www.montiboutique.com/it-IT/uomo/designer/fendi

class PradaVipMan
    #include + クラス名
    include Alducadaosta
    include Suit
    include Tessabit
    include Coltorti
    #include Leamfarfetch leamはレディース無いらしい
    include GbFarfetchWoman
    include Nugnes
    include Gaudenzi
    include Wise

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "695"
    #vip_prada_man = FendiVipWoman.new

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = ["https://www.alducadaosta.com/it/donna/designer/fendi",
    "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=15514",
    #"https://www.brunarosso.com/s/designers/fendi/?category=men",
    "https://suitnegozi.com/collections/fendi-donna",
    "https://www.tessabit.com/it/donna/designers/fendi",
    "https://www.farfetch.com/it/shopping/men/leam/items.aspx?view=90&scale=282&designer=15514",
    "https://nugnes1920.com/collections/fendi-woman",
    "https://www.gaudenziboutique.com/en-IT/women/designer/fendi",
    "https://www.coltortiboutique.com/it/designer/fendi?cat=166",
    "https://www.wiseboutique.com/it_it/donna/designers/fendi.html"
    #"https://www.montiboutique.com/it-IT/Uomo/designer/fendi"
    #"https://www.sigrun-woehr.com/en/By-Brand/Fendi/"
    #"https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=15514"
    ]

    vip_prada_man = PradaVipMan.new
    @price = PradaVipMan.call_price
    @category = PradaVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.alducadaosta.com/it/donna/designer/fendi" then
            vip_prada_man.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "https://www.brunarosso.com/s/designers/fendi/?category=men" then
        #    vip_prada_man.brunarosso_crawl(attack_site_url, @@price, @@category)
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=15514" then
            vip_prada_man.gbfarfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=166" then
            vip_prada_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/fendi-donna" then
            vip_prada_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/donna/designers/fendi" then
            vip_prada_man.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://nugnes1920.com/collections/fendi-woman" then
            vip_prada_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-IT/women/designer/fendi" then
            vip_prada_man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/fendi.html" then
            vip_prada_man.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://www.wiseboutique.com/it_it/donna/designers/fendi.html" then
        #    vip_prada_man.sigrun_crawl(attack_site_url, @@price)
        end
    end
