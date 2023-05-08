require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#harresoeも確認すること

class MargielaVipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby margiela_man_v.rb
    @category = "アクセ"
    @price = "400"
    @currency = 144.2
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoMan, Blondie, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
    def self.call_currency
        @currency
    end
end

ATTACK_LIST_URL = [
    "https://amrstore.com/collections/maison-margiela",
    "https://www.farfetch.com/be/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=4981",
    "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151",
    "https://eleonorabonucci.com/en/maison-margiela/men",
    "https://www.michelefranzesemoda.com/it/uomo/designer/maison-margiela/",
    "https://nugnes1920.com/collections/maison-margiela-man",
    "https://suitnegozi.com/collections/maison-margiela-uomo",

    #selenium
    "https://www.alducadaosta.com/it/uomo/designer/maison_margiela",
    "https://www.minettiangeloonline.com/it/man?idt=39",
    #"https://www.brunarosso.com/s/designers/maison-margiela/?category=men",
    "https://www.gebnegozionline.com/it_it/uomo/designers/maison-margiela.html",
    "https://www.wiseboutique.com/it_it/uomo/designers/maison-margiela.html",
    "http://specialshop.atelier98.net/it/uomo?idt=1980000843",
    "https://www.blondieshop.com/it/uomo/man-designer/maison-margiela.html",
    "https://www.montiboutique.com/it-IT/uomo/designer/maison_martin_margiela"
]

margiela_vip_man = MargielaVipMan.new
@price = MargielaVipMan.call_price
@category = MargielaVipMan.call_category
@currency = MargielaVipMan.call_currency

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://amrstore.com/collections/maison-margiela"
        margiela_vip_man.amr_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.farfetch.com/be/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=4981" 
        margiela_vip_man.amr_farfetch_crawl(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151" 
        margiela_vip_man.coltorti_crawl(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://eleonorabonucci.com/en/maison-margiela/men/new-collection" 
        margiela_vip_man.eleonorabonucci_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.michelefranzesemoda.com/it/uomo/designer/maison-margiela/"
        #currencyの入力が無い時は処理を飛ばす
        if (@currency != "") then 
            margiela_vip_man.michele_crawl(attack_site_url, @price, @currency)
        end
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
    when "https://www.minettiangeloonline.com/it/man?idt=39"
        margiela_vip_man.angelo_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.brunarosso.com/s/designers/maison-margiela/?category=men" 
        margiela_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
        #商品桁数はいじらない
    when "https://www.blondieshop.com/it/uomo/man-designer/maison-margiela.html" 
        margiela_vip_man.blondie_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.gebnegozionline.com/it_it/uomo/designers/maison-margiela.html"
        margiela_vip_man.gb_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.montiboutique.com/it-IT/uomo/designer/maison_martin_margiela"
        margiela_vip_man.monti_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "http://specialshop.atelier98.net/it/uomo?idt=1980000843" 
        margiela_vip_man.tessabit_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".") #B2Bサイトはドットなので対応
    when "https://www.wiseboutique.com/it_it/uomo/designers/maison-margiela.html"
        margiela_vip_man.wise_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(",")
    end
end

# https://www.coltortiboutique.com/it/designer/maison_margiela?cat=151
# https://suitnegozi.com/collections/maison-margiela-uomo
# https://www.alducadaosta.com/it/uomo/designer/maison_margiela
# https://www.brunarosso.com/s/designers/maison-margiela/?category=men
# https://www.gebnegozionline.com/it_it/uomo/designers/maison-margiela.html
# https://www.wiseboutique.com/it_it/uomo/designers/maison-margiela.html
# https://nugnes1920.com/collections/maison-margiela-man
# https://eleonorabonucci.com/en/maison-margiela/men/new-collection
# https://amrstore.com/collections/maison-margiela
# https://www.farfetch.com/be/shopping/men/AMR/items.aspx?view=90&scale=282&rootCategory=Men&designer=4981
# https://www.montiboutique.com/it-IT/uomo/designer/maison_martin_margiela
# https://www.tessabit.com/it_it/uomo/designers/maison-margiela.html?page=1
# https://www.michelefranzesemoda.com/it/uomo/designer/maison-margiela/
# https://www.blondieshop.com/it/uomo/man-designer/maison-margiela.html