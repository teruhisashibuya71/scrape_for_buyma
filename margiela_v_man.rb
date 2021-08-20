require 'rubygems'
require 'nokogiri'
require 'open-uri'

require './gb'
require './coltorti'
#require './brunarosso_f_man'
require './alducadaosta'
require './tessabit'
require './suit'
#require './blondie_f_man'
require './wise'
require './nugnes'
#require './eleonorabonucci_f_man'
require './monti'
#require './amr'
#require './amr_f_man'



class MargielaVipMan
    #include + クラス名
    include Gb
    include Coltorti
    #include BrunarossoFarfetchMan
    include Alducadaosta
    include Tessabit
    include Suit
    #include BlondieFarfetchMan
    #include Wise
    include Nugnes
    #include EleonorabonucciFarfetchMan
    #include MontiFarfetchMan
    #include Amr
    #include AmrFarfetchMan


    #服 靴 バッグ アクセ の4種類で対応する
    #価格入力欄
    @category = "バッグ"
    @price = "1290"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end


ATTACK_LIST_URL = ["https://www.gebnegozionline.com/it_it/uomo/designers/maison-margiela.html",
    "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151",
    "https://www.alducadaosta.com/it/uomo/designer/maison_margiela",
    #"https://www.brunarosso.com/s/designers/fendi/?category=men"
    "https://www.tessabit.com/it/uomo/designers/maison-margiela",
    "https://suitnegozi.com/collections/maison-margiela-uomo",
    #"https://www.blondieshop.com/jp/man/man-designer/maison-margiela.html?___store=jp&___from_store=it"
    #"https://www.wiseboutique.com/it_it/uomo/designers/maison-margiela.html"
    "https://nugnes1920.com/collections/maison-margiela-man"
    #"https://eleonorabonucci.com/en/maison-margiela/men/new-collection"
    #"https://www.montiboutique.com/it-IT/uomo/designer/maison_martin_margiela"
    #"https://amrstore.com/collections/maison-margiela"
    ]

    margiela_vip_man = MargielaVipMan.new
    @price = MargielaVipMan.call_price
    @category = MargielaVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.gebnegozionline.com/it_it/uomo/designers/maison-margiela.html" then
            margiela_vip_man.gb_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151" then
            margiela_vip_man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.alducadaosta.com/it/uomo/designer/maison_margiela" then
            margiela_vip_man.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "https://www.brunarosso.com/s/designers/fendi/?category=men" then
        #    margiela_vip_man.brunarosso_crawl(attack_site_url, @@price, @@category)
        when "https://www.tessabit.com/it/uomo/designers/maison-margiela" then
            margiela_vip_man.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://suitnegozi.com/collections/maison-margiela-uomo" then
            margiela_vip_man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        # when "https://suitnegozi.com/collections/maison-margiela-uomo" then
        #     margiela_vip_man.suit_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        # when "https://www.wiseboutique.com/it_it/uomo/designers/maison-margiela.html" then
        #     margiela_vip_man.wise_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        # when "https://eleonorabonucci.com/en/maison-margiela/men/new-collection" then
        #     margiela_vip_man.dope_farfetch_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/maison_martin_margiela" then
            margiela_vip_man.monti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://amrstore.com/collections/maison-margiela" then
            margiela_vip_man.blondie_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/men/AMR/items.aspx?view=90&scale=282&designer=4981" then
            margiela_vip_man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")

        
        
        
        
        end
    end
