require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'



#require ./ファイル名
require './actuelb'
require './auzmendi_f_woman'
require './amr'
require './amr_f_woman'
require './coltorti_woman'
require './gaudenzi'
require './leam'
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



class PradaVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "バッグ"
    @price = "1050"
    
    include Actuelb
    include Amr
    include AmrFarfetchWoman
    include AuzmendiFarfetchWoman
    include ColtortiWoman
    include Gaudenzi
    include Leam
    include Nugnes
    include Russocapri
    include SigrunWoehr
    include Suit
    include WiseFarfetchWoman

    #seleniumm系
    include Alducadaosta
    include BrunarossoWoman
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
    "https://amrstore.com/collections/prada",
    "https://amrstore.com/collections/prada-handbags",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=34624",
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=34624",
    "https://www.coltortiboutique.com/it/designer/prada?cat=166",
    "https://nugnes1920.com/collections/prada-woman",
    "https://www.sigrun-woehr.com/en/SHOES/All-Shoes/41-oxid-2020.html",
    "https://suitnegozi.com/collections/prada-donna",
    
    #selenium
    "https://www.blondieshop.com/it/donna/woman-designer/prada.html",
    "https://www.gebnegozionline.com/it_it/donna/designers/prada.html",
    "https://www.montiboutique.com/it-IT/donna/designer/prada",
    "https://www.tessabit.com/it_it/donna/designers/prada.html?page=1"
] 

    vip_prada_woman = PradaVipWoman.new
    @price = PradaVipWoman.call_price
    @category = PradaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/prada"
            vip_prada_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=34624"
            vip_prada_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://amrstore.com/collections/prada-handbags"
            if (@category == "バッグ")
                vip_prada_woman.amr_crawl(attack_site_url, @price)
                @price = @price.delete(".")
            end
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=34624"
            vip_prada_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/prada?cat=166"
            vip_prada_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/prada-woman"
            vip_prada_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/SHOES/All-Shoes/41-oxid-2020.html"
            vip_prada_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/prada-donna"
            vip_prada_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #selenium
        when "https://www.blondieshop.com/it/donna/woman-designer/prada.html"
            vip_prada_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/prada.html"
            vip_prada_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/prada"
            vip_prada_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/prada.html?page=1"
            vip_prada_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
