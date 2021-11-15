require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

#require ./ファイル名
require './actuelb'
require './amr'
require './amr_f_man'
require './auzmendi_f_man'
require './coltorti_man'
require './gaudenzi'
require './leam'
require './michelef'
require './nugnes'
require './russocapri'
require './suit'
#require './wise_f_man' #monclerは価格違いがあるので

#selenium系
require './alducadaosta'
require './brunarosso_man'
require './blondie'
require './eleonorabonucci'
require './gb'
require './monti'
require './tessabit'
require './wise'


class MargielaVipMan
    
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "アクセ"
    @price = "290"
    
    include Actuelb
    include Amr
    include AmrFarfetchMan
    include AuzmendiFarfetchMan
    include ColtortiMan
    include Gaudenzi
    include Leam
    include Michelefranzese
    include Nugnes
    include Russocapri
    include Suit
    #include WiseFarfetchMan

    #seleniumm系
    include Alducadaosta
    include BrunarossoMan
    include Blondie
    include Eleonorabonucci
    include Gb
    include Monti
    include Tessabit
    include Wise

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    "https://amrstore.com/collections/maison-margiela",
    "https://www.farfetch.com/be/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=4981",
    "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151",
    "https://www.michelefranzesemoda.com/it/uomo/designer/maison-margiela/",
    "https://nugnes1920.com/collections/maison-margiela-man",
    "https://suitnegozi.com/collections/maison-margiela-uomo",

    #selenium
    "https://www.alducadaosta.com/it/uomo/designer/maison_margiela",
    "https://www.brunarosso.com/s/designers/maison-margiela/?category=men",
    "https://www.blondieshop.com/it/uomo/man-designer/maison-margiela.html",
    "https://eleonorabonucci.com/en/maison-margiela/men/new-collection",
    "https://www.gebnegozionline.com/it_it/uomo/designers/maison-margiela.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/maison_martin_margiela",
    # 消えた "https://www.tessabit.com/it_it/uomo/designers/maison-margiela.html?page=1",
    "https://www.wiseboutique.com/it_it/uomo/designers/maison-margiela.html"
]

margiela_vip_man = MargielaVipMan.new
@price = MargielaVipMan.call_price
@category = MargielaVipMan.call_category

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://amrstore.com/collections/maison-margiela"
        margiela_vip_man.amr_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.farfetch.com/be/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=4981" 
        margiela_vip_man.amr_farfetch_crawl(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151" 
        margiela_vip_man.coltorti_crawl(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.michelefranzesemoda.com/it/uomo/designer/maison-margiela/"
        margiela_vip_man.michele_crawl(attack_site_url, @price)
        #価格調整無し
    when "https://nugnes1920.com/collections/maison-margiela-man" 
        margiela_vip_man.nugnes_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://suitnegozi.com/collections/maison-margiela-uomo" 
        margiela_vip_man.suit_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    
    #selenium
    when "https://www.alducadaosta.com/it/uomo/designer/maison_margiela"
        margiela_vip_man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.brunarosso.com/s/designers/maison-margiela/?category=men" 
        margiela_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
        #商品桁数はいじらない
    when "https://www.blondieshop.com/it/uomo/man-designer/maison-margiela.html" 
        margiela_vip_man.blondie_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://eleonorabonucci.com/en/maison-margiela/men/new-collection" 
        margiela_vip_man.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.gebnegozionline.com/it_it/uomo/designers/maison-margiela.html"
        margiela_vip_man.gb_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.montiboutique.com/it-IT/uomo/designer/maison_martin_margiela"
        margiela_vip_man.monti_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
    #when "https://www.tessabit.com/it_it/uomo/designers/maison-margiela.html?page=1"
    #    margiela_vip_man.tessabit_crawl_selenium(attack_site_url, @price)
    #    @price = @price.delete(",")
    when "https://www.wiseboutique.com/it_it/uomo/designers/maison-margiela.html"
        margiela_vip_man.wise_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(",")
    end
end
