#tessabit
#sigrun
#monti
#wise

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


#require ./ファイル名
require './actuelb'
require './alducadaosta'
require './auzmendi_f_woman'
require './amr_f_woman'
require './coltorti'
require './eleonorabonucci_f_woman'
require './gaudenzi'
require './gb_f_woman'
require './leam'
require './nugnes'
require './russocapri'
require './sigrun'
require './suit'
require './tessabit'
require './wise_f_woman'


#selenium系
require './brunarosso_woman'
require './blondie'
#require './eleonorabonucci'
#require './gb'
require './monti'
#require './wise'


class IsabelVip

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"
    
    include Actuelb
    include Alducadaosta
    include AuzmendiFarfetchWoman
    #----------------------
    #include Amr
    #----------------------
    include AmrFarfetchMan
    include AmrFarfetchWoman
    include Coltorti
    include EleonorabonucciFarfetchWoman
    include Gaudenzi
    include GbFarfetchWoman
    include Leam
    include Nugnes
    include Russocapri
    include SigrunWoehr
    include Suit
    include Tessabit
    include WiseFarfetchWoman
    
    #seleniumm系
    include BrunarossoWoman
    include Blondie
    #include Eleonorabonucci
    #----------------------
    #include GB
    #----------------------
    include Monti
    #----------------------
    #include Wise
    #----------------------

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    #"actuelB",
    "https://www.alducadaosta.com/it/donna/designer/stella_mccartney",
    #""AuzmendiFarfetchWoman,
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502",
    "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166",
    "https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502",
    #"Gaudenzi",
    "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502",
    "https://www.leam.com/it_eu/designer/stella-mccartney-donna.html",
    "https://nugnes1920.com/collections/stella-mccartney-woman",
    "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney",
    #"sigtrun",
    "https://suitnegozi.com/collections/stella-mccartney-donna",
    "https://www.tessabit.com/it/donna/designers/stella-mccartney",
    "https://www.farfetch.com/it/shopping/women/wise-boutique/items.aspx?view=90&scale=274&rootCategory=Women&designer=20851",
    
    #以下selenium
    "https://www.brunarosso.com/s/designers/stella-mccartney/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.htmls",
    #"eleonorabonucci",
    #"gb",
    "https://www.montiboutique.com/en-US/women/designer/stella_mccartney"
]

    vip_isabel_woman = IsabelVip.new
    @price = IsabelVip.call_price
    @category = IsabelVip.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        # when "actuelb" then
        #     vip_isabel_woman.actuel_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(",")
        when "https://www.alducadaosta.com/it/donna/designer/stella_mccartney" then
            vip_isabel_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "auzmendi" then
        #     vip_isabel_woman.auzumendi_f_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502" then
            vip_isabel_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166" then
            vip_isabel_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/max_mara" then
            vip_isabel_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502" then
            vip_isabel_woman.elenora_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=5502" then
            vip_isabel_woman.gbfarfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "gaudenzi" then
        #     vip_isabel_woman.gaudenzi_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/stella-mccartney-donna.html" then
            vip_isabel_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/stella-mccartney-woman" then
            vip_isabel_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney" then
            vip_isabel_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        # when "sigrun" then
        #     vip_isabel_woman.sigrun_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "https://suitnegozi.com/collections/stella-mccartney-donna" then
            vip_isabel_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/donna/designers/stella-mccartney" then
            vip_isabel_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/wise-boutique/items.aspx?view=90&scale=274&rootCategory=Women&designer=20851" then
            vip_isabel_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.brunarosso.com/s/designers/stella-mccartney/?category=women" then
            vip_isabel_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.html" then
            vip_isabel_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        # when "eleonorabonucci" then
        #     vip_isabel_woman.elenora_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "gb" then
        #     vip_isabel_woman.gb_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/stella_mccartney" then
            vip_isabel_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "wise" then
        #    vip_isabel_woman.wise_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        end
    end

