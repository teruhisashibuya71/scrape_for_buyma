#いちよう完成! 9月12日

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


#require ./ファイル名
#require './actuelb'
require './alducadaosta'
#require './auzmendi_f_man'
#require './auzmendi_f_woman'
#----------------------
#require './amr'
#----------------------
#require './amr_f_man'
#require './amr_f_woman'
require './coltorti'
#require './eleonorabonucci_f_man'
#require './eleonorabonucci_f_woman'
require './gaudenzi'
#require './gb_f_man'
#require './gb_f_woman'
require './leam'
require './nugnes'
require './russocapri'
#require './sigrun'
require './suit'
require './tessabit'
#require './wise_f_man'
#require './wise_f_woman'


#selenium系
#require './brunarosso_man'
require './brunarosso_woman'
require './blondie'
#require './eleonorabonucci'
#----------------------
#require './gb'
#----------------------
require './monti'
#----------------------
#require './wise'
#----------------------



class StellaVipWoman
    
    #include Actuelb
    include Alducadaosta
    #include AuzmendiFarfetchman
    #include AuzmendiFarfetchWoman
    #----------------------
    #include AmrFarfetchMan
    #----------------------
    #include AmrFarfetchMan
    #include AmrFarfetchWoman
    include Coltorti
    #include EleonorabonucciFarfetchMan
    #include EleonorabonucciFarfetchWoman
    include Gaudenzi
    #include GbFarfetchMan
    #include GbFarfetchWoman
    include Leam
    include Nugnes
    include Russocapri
    #include SigrunWoehr
    include Suit
    include Tessabit
    #include WiseFarfetchMan
    #include WiseFarfetchWoman

    
    #seleniumm系
    #include BrunarossoMan
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
    

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"
    #vip_stella_woman = FendiVipWoman.new

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    #"actuelB",
    "https://www.alducadaosta.com/it/donna/designer/max_mara",
    "https://amrstore.com/collections/max-mara",
    #""AuzmendiFarfetchWoman,
    #"https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502",
    "https://www.coltortiboutique.com/it/designer/max_mara?cat=166",
    #"https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502",
    "https://www.gaudenziboutique.com/en-it/women/designer/max_mara",
    #"https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502",
    "https://www.leam.com/en_en/designer/max-mara-women.html",
    "https://nugnes1920.com/collections/max-mara-woman",
    "https://www.russocapri.com/en/all/designer/max-mara/groups",
    #"sigtrun",
    "https://suitnegozi.com/collections/max-mara-donna?custom_sort_by=created-descending&pagination=1&page=1",
    "https://www.tessabit.com/it_it/donna/designers/max-mara.html?page=1",
    #"https://www.farfetch.com/it/shopping/women/wise-boutique/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502",
    
    #selenium
    "https://www.brunarosso.com/s/designers/max-mara/?category=women",
    "https://www.blondieshop.com/it/woman/woman-designer/max-mara.html?___store=jp&___from_store=it&p=1",
    #"eleonorabonucci",
    #"gb",
    "https://www.montiboutique.com/it-IT/Donna/designer/max_mara"
    #"https://www.wiseboutique.com/it_it/donna/designers/max-mara.html"
]

    vip_stella_woman = StellaVipWoman.new
    @price = StellaVipWomanStellaVipWoman.call_price
    @category = FendiVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        # when "actuelb" then
        #     vip_stella_woman.actuel_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(",")
        when "https://www.alducadaosta.com/it/donna/designer/max_mara" then
            vip_stella_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "https://amrstore.com/collections/max-mara" then
        #    vip_stella_woman.amr_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        # when "auzmendi" then
        #     vip_stella_woman.auzumendi_f_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502" then
        #     vip_stella_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/max_mara?cat=166" then
            vip_stella_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/max_mara" then
            vip_stella_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502" then
        #     vip_stella_woman.elenora_farfetch_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=5502" then
        #     vip_stella_woman.gbfarfetch_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "gaudenzi" then
        #     vip_stella_woman.gaudenzi_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.leam.com/en_en/designer/max-mara-women.html" then
            vip_stella_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/max-mara-woman" then
            vip_stella_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/en/all/designer/max-mara/groups" then
            vip_stella_woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        # when "sigrun" then
        #     vip_stella_woman.sigrun_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "https://suitnegozi.com/collections/max-mara-donna?custom_sort_by=created-descending&pagination=1&page=1" then
            vip_stella_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/max-mara.html?page=1" then
            vip_stella_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        # when "https://www.farfetch.com/it/shopping/women/wise-boutique/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502" then
        #     vip_stella_woman.wise_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
            
        #以下selenium
        when "https://www.brunarosso.com/s/designers/max-mara/?category=women" then
            vip_stella_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/woman/woman-designer/max-mara.html?___store=jp&___from_store=it&p=1" then
            vip_stella_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        # when "eleonorabonucci" then
        #     vip_stella_woman.elenora_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "gb" then
        #     vip_stella_woman.gb_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/max_mara" then
            vip_stella_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/max-mara.html" then
            vip_stella_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
            
        end
    end

