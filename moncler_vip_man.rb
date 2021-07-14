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


class MonclerVipMan

    include Alducadaosta
    include Suit
    include Tessabit
    include Gaudenzi
    include Coltorti
    include Leamfarfetch
    include GbFarfetchMan
    include Nugnes
    #LEAM
    #azumendi
    #russocapri
    #brunarosso
    #GBoriginal
    #include Monti
    #actuel
    #harreso→ここは無理
    #blondie
    #cortessi

    ATTACK_LIST_URL = [#"https://www.alducadaosta.com/it/uomo/designer/moncler",
                       #"https://suitnegozi.com/collections/moncler-uomo",
                       # "https://www.tessabit.com/it/uomo/designers/moncler",
                       # "https://www.coltortiboutique.com/it/designer/moncler?cat=151",
                       # "https://www.farfetch.com/it/shopping/men/leam/items.aspx?view=90&scale=282&designer=4535",
                       # "https://nugnes1920.com/collections/prada-man",
                       # "https://www.gaudenziboutique.com/it-IT/uomo/designer/givenchy",
                       #"https://nugnes1920.com/collections/moncler-man"
                    ]

    #服 靴 バッグ アクセ の4種類で対応する
    @@category = "靴"
    @price = "650"

    # def self.call_price
    #     @price
    # end

    moncler_vip_man = MonclerVipMan.new

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.alducadaosta.com/it/uomo/designer/moncler" then
            moncler_vip_man.alducadaosta_clowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/moncler-uomo" then
            moncler_vip_man.suit_clowl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/uomo/designers/Fendi" then
            moncler_vip_man.tessabit_clowl(attack_site_url, @price, @@category)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=151" then
            moncler_vip_man.coltorti_clowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/men/leam/items.aspx?view=90&scale=282&designer=4535" then
            moncler_vip_man.leamfarfetch_crowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/fendi-man" then
            moncler_vip_man.nugnes_clowl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/it-IT/uomo/designer/fendi" then
            moncler_vip_man.gaudenzi_clowl(attack_site_url, @price, @@category)
            @price = @price.delete(".")
        end
    end
end
