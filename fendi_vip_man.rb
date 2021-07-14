require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require './alducadaosta'
require './suit'
require './tessabit'
require './coltorti'
require './leamfarfetch'
require './gb_f_man'
require './brunarosso'
require './nugnes'
require './gaudenzi'
#require './wise'
#require './monti'


class FendiVip

    include Alducadaosta
    include Suit
    include Tessabit
    include Coltorti
    include Leamfarfetch
    include GbFarfetchMan
    include Nugnes
    include Gaudenzi
    #include Wise
    #include Monti

    ATTACK_LIST_URL = [#"https://www.alducadaosta.com/it/uomo/designer/fendi",
                        "https://www.farfetch.com/it/shopping/men/G-B/items.aspx?view=90&scale=282&designer=15514"
                       # "https://www.brunarosso.com/s/designers/fendi/?category=men",
                       # "https://suitnegozi.com/collections/fendi-uomo",
                       # "https://www.tessabit.com/it/en/man/designers/fendi",
                       # "https://www.coltortiboutique.com/it/designer/fendi?cat=151",
                       # "https://www.farfetch.com/it/shopping/men/leam/items.aspx?view=90&scale=282&designer=15514",
                       # "https://nugnes1920.com/collections/prada-man",
                       # "https://www.gaudenziboutique.com/it-IT/uomo/designer/givenchy",
                       # "https://www.wiseboutique.com/it_it/uomo/designers/fendi.html",
                        #"https://www.montiboutique.com/it-IT/Uomo/designer/fendi"
                    ]

    #服 靴 バッグ アクセ の4種類で対応する
    @@category = "靴"
    @price = "650"

    def self.call_price
        @price
    end

    fendi_vip = FendiVip.new

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.alducadaosta.com/it/uomo/designer/fendi" then
            fendi_vip.alducadaosta_clowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        #when "https://www.brunarosso.com/s/designers/fendi/?category=men" then
        #    fendi_vip.brunarosso_crowl(attack_site_url, @@price, @@category)
        when "https://www.farfetch.com/it/shopping/men/G-B/items.aspx?view=90&scale=282&designer=15514" then
            fendi_vip.gbfarfetch_crowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=151" then
            fendi_vip.coltorti_clowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/fendi-uomo" then
            fendi_vip.suit_clowl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/uomo/designers/Fendi" then
            fendi_vip.tessabit_clowl(attack_site_url, @price, @@category)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/men/leam/items.aspx?view=90&scale=282&designer=15514" then
            fendi_vip.leamfarfetch_crowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/fendi-man" then
            fendi_vip.nugnes_clowl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/it-IT/uomo/designer/fendi" then
            fendi_vip.gaudenzi_clowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/uomo/designers/fendi.html" then
            fendi_vip.wise_clowl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Uomo/designer/fendi" then
            fendi_vip.monti_crowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        end
    end
end