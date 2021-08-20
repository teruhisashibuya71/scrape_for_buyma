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

class StellaVipWoman
    
    include Alducadaosta
    include Suit
    include Tessabit
    include Coltorti
    include GbFarfetchWoman
    include Nugnes
    include Gaudenzi

    #簡単に組めそうなところ
    #russo
    #leam
    #amr
    #wise
    #sigrun

    #むずいところ
    #blondie
    #burunaosso
    #monti
    

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"
    #vip_stella_woman = FendiVipWoman.new

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = ["https://www.alducadaosta.com/it/donna/designer/stella_mccartney",
    "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=15514",
    "https://suitnegozi.com/collections/stella-mccartney-donna",
    "https://www.tessabit.com/it/donna/designers/stella-mccartney",
    #farfetchのGB
    "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=5502",
    "https://nugnes1920.com/collections/fendi-woman",
    "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166",    
    ]

    vip_stella_woman = FendiVipWoman.new
    @price = FendiVipWoman.call_price
    @category = FendiVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.alducadaosta.com/it/donna/designer/stella_mccartney" then
            vip_stella_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #farfetchのGB
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=5502" then
            vip_stella_woman.gbfarfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166" then
            vip_stella_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/stella-mccartney-donna" then
            vip_stella_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/donna/designers/stella-mccartney" then
            vip_stella_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://nugnes1920.com/collections/fendi-woman" then
            vip_stella_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-IT/women/designer/fendi" then
            vip_stella_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/fendi.html" then
            vip_stella_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end

