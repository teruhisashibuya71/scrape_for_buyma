require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'



#require ./ファイル名
#require './actuelb'
require './alducadaosta'
#require './auzmendi_f_woman'
require './amr_f_woman'
require './coltorti'
require './eleonorabonucci_f_woman'
#require './gaudenzi'
require './gb_f_woman'
require './leam'
require './nugnes'
require './russocapri'
#require './sigrun'
require './suit'
require './tessabit'
#require './wise'
require './wise_f_woman'


#selenium系
require './brunarosso_woman'
require './blondie'
#require './eleonorabonucci'
#require './gb'
require './monti'



class StellaVipWoman
    
    #include Actuelb
    include Alducadaosta
    #include AuzmendiFarfetchWoman
    include AmrFarfetchWoman
    include Coltorti
    include EleonorabonucciFarfetchWoman
    #include Gaudenzi
    include GbFarfetchWoman
    include Nugnes
    include Russocapri
    #include SigrunWoehr
    include Suit
    include Tessabit
    include WiseFarfetchWoman

    
    #seleniumm系
    include BrunarossoWoman
    include Blondie
    #include Eleonorabonucci
    #include GB
    include Monti
    

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"
    #stella_vip_woman = FendiVipWoman.new

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    ##"actuelB",
    #"https://www.alducadaosta.com/it/donna/designer/stella_mccartney",
    ##""AuzmendiFarfetchWoman,
    #"https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502",
    #"https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166",
    #"https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502",
    ##"Gaudenzi",
    #"https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502",
    #"https://www.leam.com/it_eu/designer/stella-mccartney-donna.html",
    #"https://nugnes1920.com/collections/stella-mccartney-woman",
    #"https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney",
    ##"sigtrun",
    #"https://suitnegozi.com/collections/stella-mccartney-donna",
    #"https://www.tessabit.com/it/donna/designers/stella-mccartney",
    #"https://www.farfetch.com/it/shopping/women/wise-boutique/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502",
    #selenium
    "https://www.brunarosso.com/s/designers/stella-mccartney/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.htmls",
    #"eleonorabonucci",
    #"gb",
    "https://www.montiboutique.com/en-US/women/designer/stella_mccartney"
]

    stella_vip_woman = StellaVipWoman.new
    @price = StellaVipWoman.call_price
    @category = StellaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        # when "actuelb" then
        #     stella_vip_woman.actuel_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(",")
        when "https://www.alducadaosta.com/it/donna/designer/stella_mccartney" then
            stella_vip_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "auzmendi" then
        #     stella_vip_woman.auzumendi_f_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502" then
            stella_vip_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166" then
            stella_vip_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502" then
            stella_vip_woman.elenora_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=5502" then
            stella_vip_woman.gbfarfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "gaudenzi" then
        #     stella_vip_woman.gaudenzi_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/stella-mccartney-donna.html" then
            stella_vip_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/stella-mccartney-woman" then
            stella_vip_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney" then
            stella_vip_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        # when "sigrun" then
        #     stella_vip_woman.sigrun_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "https://suitnegozi.com/collections/stella-mccartney-donna" then
            stella_vip_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/donna/designers/stella-mccartney" then
            stella_vip_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/wise-boutique/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502" then
            stella_vip_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            #selenium
        when "https://www.brunarosso.com/s/designers/stella-mccartney/?category=women" then
            stella_vip_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.html" then
            stella_vip_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        # when "eleonorabonucci" then
        #     stella_vip_woman.elenora_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "gb" then
        #     stella_vip_woman.gb_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/stella_mccartney" then
            stella_vip_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        end
    end

