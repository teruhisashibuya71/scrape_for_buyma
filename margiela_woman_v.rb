require 'rubygems'
require 'nokogiri'
require 'open-uri'


#require ./ファイル名
require './actuelb'
require './auzmendi_f_woman'
require './amr'
require './amr_f_woman'
require './coltorti_woman'
require './gaudenzi'
require './leam'
require './michelef'
require './nugnes'
require './russocapri'
require './sigrun'
require './suit'
require './wise_f_woman' #monclerの価格違いあるので

#selenium系
require './alducadaosta'
require './brunarosso_woman'
require './blondie'
require './eleonorabonucci' #サイズ35〜
require './gb'
require './monti'
require './tessabit'
require './wise'



class MargielaVipWoman
    
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"

    #include + クラス名
    include Actuelb
    include Amr
    include AmrFarfetchWoman
    include AuzmendiFarfetchWoman
    include ColtortiWoman
    include Gaudenzi
    include Leam
    include Michelefranzese
    include Nugnes
    include Russocapri
    include SigrunWoehr
    include Suit
    include WiseFarfetchWoman

    #seleniumm系
    include Alducadaosta
    include BrunarossoWoman
    include Blondi
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
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=4981",
    "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=166",
    "https://www.gaudenziboutique.com/en-it/women/designer/maison_margiela",
    "https://nugnes1920.com/collections/maison-margiela-woman",
    "https://suitnegozi.com/collections/maison-margiela-donna",

    #selenium
    "https://www.alducadaosta.com/it/donna/designer/maison_margiela",
    "https://www.brunarosso.com/s/designers/maison-margiela/",
    "https://www.blondieshop.com/jp/woman/woman-designer/maison-margiela.html",
    "https://eleonorabonucci.com/en/maison-margiela/women/new-collection",
    #"https://eleonorabonucci.com/en/maison-margiela-x-reebok/women/new-collection",
    "https://www.gebnegozionline.com/it_it/donna/designers/maison-margiela.html",
    "https://www.montiboutique.com/it-IT/donna/designer/maison_martin_margiela",
    "https://www.tessabit.com/it_it/donna/designers/maison-margiela.html?page=1",
    "https://www.wiseboutique.com/it_it/donna/designers/maison-margiela.html"  
]

    vip_margiela_woman = MargielaVipWoman.new
    @price = MargielaVipWoman.call_price
    @category = MargielaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/maison-margiela"
            vip_margiela_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=4981"
            vip_Margiela_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
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
        when "https://www.brunarosso.com/s/designers/maison-margiela/"
            vip_margiela_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/jp/woman/woman-designer/maison-margiela.html"
            vip_margiela_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/maison-margiela/women/new-collection"
            vip_margiela_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #Margiela × reebok
        # when  "https://eleonorabonucci.com/en/maison-margiela-x-reebok/women/new-collection" 
        #     vip_margiela_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/maison-margiela.html"
            vip_margiela_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/maison_martin_margiela"
            vip_margiela_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/maison-margiela.html?page=1"
            vip_margiela_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/maison-margiela.html"
            vip_margiela_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
