require 'rubygems'
require 'nokogiri'
require 'open-uri'



require './amr_f_man'
require './coltorti'
require './alducadaosta'
require './nugnes'
require './tessabit'
require './suit'
#require './wise'
require './wise_f_man'


#selenium系
require './brunarosso_man'
require './blondie'
#require './eleonorabonucci'
#require './gb'
require './monti'




class MargielaVipMan
    
    #include + クラス名
    include AmrFarfetchMan
    include Alducadaosta
    include Coltorti
    #include BrunarossoFarfetchMan
    include Nugnes
    include Suit
    include Tessabit  
    #include BlondieFarfetchMan
    #include EleonorabonucciFarfetchMan
    #include MontiFarfetchMan
    #include Wise
    #include Wise
    include WiseFarfetchMan
    
    
    #selenium
    include BrunarossoMan
    include Blondie
    #include eleonorabonucci
    #include Gb
    include Monti
    
    #服 靴 バッグ アクセ の4種類で対応する
    #価格入力欄
    @category = "靴"
    @price = "990"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end


ATTACK_LIST_URL = [
    "https://www.farfetch.com/be/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=4981",
    "https://www.alducadaosta.com/it/uomo/designer/maison_margiela",
    "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151",
    "https://nugnes1920.com/collections/maison-margiela-man",
    "https://suitnegozi.com/collections/maison-margiela-uomo",    
    "https://www.tessabit.com/it/uomo/designers/maison-margiela",
    #"https://www.wiseboutique.com/it_it/uomo/designers/maison-margiela.html",
    "https://www.farfetch.com/it/shopping/men/wise-boutique/items.aspx?view=90&scale=282&rootCategory=Men&designer=4981",
    #selenium
    "https://www.brunarosso.com/s/designers/maison-margiela/?category=men",
    "https://www.blondieshop.com/it/uomo/man-designer/maison-margiela.html",
    #eleonorabonucci",
    #"gb",
    "https://www.montiboutique.com/it-IT/uomo/designer/maison_martin_margiela"
    ]

    margiela_vip_man = MargielaVipMan.new
    @price = MargielaVipMan.call_price
    @category = MargielaVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/be/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=4981" then
        #    margiela_vip_man.amr_farfetch_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        #when "https://www.alducadaosta.com/it/uomo/designer/maison_margiela" then
        #    margiela_vip_man.alducadaosta_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        #when "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151" then
        #    margiela_vip_man.coltorti_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        #when "https://nugnes1920.com/collections/maison-margiela-man" then
        #    margiela_vip_man.nugnes_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #when "https://suitnegozi.com/collections/maison-margiela-uomo" then
        #    margiela_vip_man.suit_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #when "https://www.tessabit.com/it/uomo/designers/maison-margiela" then
        #    margiela_vip_man.tessabit_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(",")
        #when "https://www.farfetch.com/it/shopping/men/wise-boutique/items.aspx?view=90&scale=282&rootCategory=Men&designer=4981" then
        #    margiela_vip_man.wise_farfetch_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        #    #selenium
        when "https://www.brunarosso.com/s/designers/maison-margiela/?category=men" then
            margiela_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #商品桁数はいじらない
        #when "https://www.blondieshop.com/it/uomo/man-designer/maison-margiela.html" then
        #    margiela_vip_man.blondie_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        ## when "https://eleonorabonucci.com/en/maison-margiela/men/new-collection" then
        ##     margiela_vip_man.dope_farfetch_crawl(attack_site_url, @price, @category)
        ##     @price = @price.delete(".")
        ## when "https://www.gebnegozionline.com/it_it/uomo/designers/maison-margiela.html" then
        ##     margiela_vip_man.gb_crawl(attack_site_url, @price, @category)
        ##     @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/uomo/designer/maison_martin_margiela" then
            margiela_vip_man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        ## when "https://www.wiseboutique.com/it_it/uomo/designers/maison-margiela.html" then
        ##     margiela_vip_man.wise_crawl(attack_site_url, @price)
        ##     @price = @price.delete(".")
        
        end
    end
