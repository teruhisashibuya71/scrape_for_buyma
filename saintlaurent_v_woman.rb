require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

require './tessabit'
require './coltorti'
require './gb_f_woman'
require './nugnes'
require './gaudenzi'
require './leam'


class SaintLaurentVipWoman

    #include + クラス名
    include Tessabit
    include Coltorti
    include GbFarfetchWoman
    include Nugnes
    include Gaudenzi
    include Leam

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "1190"
    
    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [#"https://www.alducadaosta.com/it/donna/designer/fendi",
    "https://www.leam.com/it_eu/designer/saint-laurent-donna.html"
    #"https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=15514",
    #"https://www.brunarosso.com/s/designers/fendi/?category=men",
    #"https://suitnegozi.com/collections/fendi-donna",
    #"https://www.tessabit.com/it/donna/designers/fendi",
    #"https://www.farfetch.com/it/shopping/men/leam/items.aspx?view=90&scale=282&designer=15514",
    #"https://nugnes1920.com/collections/fendi-woman",
    #"https://www.gaudenziboutique.com/en-IT/women/designer/fendi",
    #"https://www.coltortiboutique.com/it/designer/fendi?cat=166",
    #"https://www.wiseboutique.com/it_it/donna/designers/fendi.html"
    #"https://www.montiboutique.com/it-IT/Uomo/designer/fendi"
    #"https://www.sigrun-woehr.com/en/By-Brand/Fendi/"
    #"https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=15514"
    ]

    vip_saintlaurent_woman = SaintLaurentVipWoman.new
    @price = SaintLaurentVipWoman.call_price
    @category = SaintLaurentVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.leam.com/it_eu/designer/saint-laurent-donna.html" then
            vip_saintlaurent_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.alducadaosta.com/it/donna/designer/fendi" then
            vip_saintlaurent_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "https://www.brunarosso.com/s/designers/fendi/?category=men" then
        #    vip_saintlaurent_woman.brunarosso_crawl(attack_site_url, @@price, @@category)
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=15514" then
            vip_saintlaurent_woman.gbfarfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=166" then
            vip_saintlaurent_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/fendi-donna" then
            vip_saintlaurent_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/donna/designers/fendi" then
            vip_saintlaurent_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://nugnes1920.com/collections/fendi-woman" then
            vip_saintlaurent_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-IT/women/designer/fendi" then
            vip_saintlaurent_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/fendi.html" then
            vip_saintlaurent_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://www.wiseboutique.com/it_it/donna/designers/fendi.html" then
        #    vip_saintlaurent_woman.sigrun_crawl(attack_site_url, @@price)
        end
    end
