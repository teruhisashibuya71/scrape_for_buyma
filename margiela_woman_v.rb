require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class MargielaVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby margiela_woman_v.rb
    @category = "バッグ"
    @price = "1700"
    @currency = 143.7
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Gb, Monti, Tessabit, Wise
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
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=4981",
    "https://www.residenza725.com/ue_it/designers/maison-margiela/category_donna.html",
    "https://eleonorabonucci.com/en/maison-margiela/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/maison_margiela",
    "https://nugnes1920.com/collections/maison-margiela-woman",
    "https://suitnegozi.com/collections/maison-margiela-donna",

    #selenium
    "https://www.alducadaosta.com/it/donna/designer/maison_margiela",
    "https://www.minettiangeloonline.com/it/woman?idt=39",
    "https://www.brunarosso.com/designer/476-maison-margiela-woman",
    #Margiela × Reebok
    #"https://eleonorabonucci.coｚｚm/en/maison-margiela-x-reebok/women/new-collection",
    "https://www.gebnegozionline.com/en_it/women/designers/maison-margiela.html",
    "https://www.wiseboutique.com/it_it/donna/designers/maison-margiela.html",
    "http://specialshop.atelier98.net/it/donna?idt=1980000843",
    "https://www.blondieshop.com/jp/woman/woman-designer/maison-margiela.html",
    "https://www.montiboutique.com/it-IT/donna/designer/maison_martin_margiela"
]

    vip_margiela_woman = MargielaVipWoman.new
    @price = MargielaVipWoman.call_price
    @category = MargielaVipWoman.call_category
    @currency = MargielaVipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/maison-margiela"
            vip_margiela_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=4981"
            vip_margiela_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/maison-margiela/women/new-collection"
            vip_margiela_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=166"
            vip_margiela_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/it-IT/donna/designer/maison_margiela"
            vip_margiela_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/maison-margiela-woman"
            vip_margiela_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/maison-margiela-donna"
            vip_margiela_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/maison_margiela"
            vip_margiela_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=39" 
            vip_margiela_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/476-maison-margiela-woman"
            vip_margiela_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/jp/woman/woman-designer/maison-margiela.html"
            vip_margiela_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #Margiela × reebok
        #when "https://eleonorabonucci.com/en/maison-margiela-x-reebok/women/new-collection" 
        #    vip_margiela_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/maison-margiela.html"
            vip_margiela_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/maison_martin_margiela"
            vip_margiela_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000843"
            vip_margiela_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/maison-margiela.html"
            vip_margiela_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
