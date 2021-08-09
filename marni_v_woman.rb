#require './ファイル名'
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
require './nugnes'
require './gaudenzi'
require './wise'
require './brunarosso_f_woman'
require './gb'
require './monti_f_woman'
require './eleonorabonucci_f_woman'
require './auzmendi_f_woman'


class MarniVipWoman
    #include + クラス名
    include Alducadaosta
    include Suit
    include Tessabit
    include Coltorti
    include GbFarfetchWoman
    include Nugnes
    include Gaudenzi
    include Wise
    include BrunarossoFarfetchWoman
    include Gb
    include MontiFarfetchWoman
    include EleonorabonucciFarfetchWoman
    include AuzmendiFarfetchWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "617"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [#"https://www.farfetch.com/it/shopping/women/bruna-rosso/items.aspx?view=90&scale=274&designer=4224",
    #"https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=15514",
    #"https://www.gebnegozionline.com/it_it/donna/designers/marni.html"
    #"https://www.farfetch.com/it/shopping/women/monti/items.aspx?view=90&scale=274&designer=4224"
    #"https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&designer=4224"
    "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=4224"
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

    vip_marni_woman = MarniVipWoman.new
    @price = MarniVipWoman.call_price
    @category = MarniVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&designer=4224" then
            vip_marni_woman.elenora_farfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")    
        when "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=4224" then
            vip_marni_woman.auzmendi_farfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")    
        when "https://www.gebnegozionline.com/it_it/donna/designers/marni.html" then
            vip_marni_woman.gb_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")    
        when "https://www.farfetch.com/it/shopping/women/monti/items.aspx?view=90&scale=274&designer=4224" then
            vip_marni_woman.monti_farfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")    
        when "https://www.farfetch.com/it/shopping/women/bruna-rosso/items.aspx?view=90&scale=274&designer=4224" then
            vip_marni_woman.bruna_farfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")    
        when "https://www.alducadaosta.com/it/donna/designer/fendi" then
            vip_marni_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "https://www.brunarosso.com/s/designers/fendi/?category=men" then
        #    vip_marni_woman.brunarosso_crowl(attack_site_url, @@price, @@category)
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=15514" then
            vip_marni_woman.gbfarfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=166" then
            vip_marni_woman.coltorti_clowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/fendi-donna" then
            vip_marni_woman.suit_clowl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/donna/designers/fendi" then
            vip_marni_woman.tessabit_clowl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://nugnes1920.com/collections/fendi-woman" then
            vip_marni_woman.nugnes_clowl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-IT/women/designer/fendi" then
            vip_marni_woman.gaudenzi_clowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/fendi.html" then
            vip_marni_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://www.wiseboutique.com/it_it/donna/designers/fendi.html" then
        #    vip_marni_woman.sigrun_clowl(attack_site_url, @@price)
        end
    end
