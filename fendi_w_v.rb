require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'



#require ./ファイル名
require './actuelb'
require './auzmendi_f_woman'
require './amr'
require './amr_f_woman'
require './coltorti'
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
require './gb_selenium'
require './monti'
require './tessabit'
require './wise'

class FendiVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "695"
    #vip_fendi_woman = FendiVipWoman.new
    
    include Actuelb
    include Amr
    include AmrFarfetchWoman
    include AuzmendiFarfetchWoman
    include Coltorti
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
    include Blondi
    include Eleonorabonucci
    include Gbselenium
    include Monti
    include Tessabit
    include Wise

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

    ATTACK_LIST_URL = [
        "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=15514",
        "https://www.coltortiboutique.com/it/designer/fendi?cat=166",
        "https://www.gaudenziboutique.com/en-IT/women/designer/fendi",
        "https://nugnes1920.com/collections/fendi-woman",
        "https://www.sigrun-woehr.com/en/By-Brand/Fendi/",
        "https://suitnegozi.com/collections/fendi-donna",
    
        #selenium
        "https://www.alducadaosta.com/it/donna/designer/fendi",
        "https://www.brunarosso.com/s/designers/fendi/?category=women",
        "https://www.gebnegozionline.com/it_it/donna/designers/fendi.html"
        "https://www.montiboutique.com/it-IT/donna/designer/fendi"
        "https://www.tessabit.com/it_it/donna/designers/fendi.html?page=1",
        "https://www.wiseboutique.com/it_it/donna/designers/fendi.html"
    ]

    vip_fendi_woman = FendiVipWoman.new
    @price = FendiVipWoman.call_price
    @category = FendiVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=15514" then
            vip_fendi_woman.auzumendi_f_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/fendi?cat=166" then
            vip_fendi_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-IT/women/designer/fendi" then
            vip_fendi_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/fendi-woman" then
            vip_fendi_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Fendi/" then
            vip_fendi_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/fendi-donna" then
            vip_fendi_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #seleniium
        when "https://www.alducadaosta.com/it/donna/designer/fendi" then
            vip_fendi_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/fendi/?category=women" then
            vip_fendi_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.gebnegozionline.com/it_it/donna/designers/fendi.html" then
            vip_fendi_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when  "https://www.montiboutique.com/it-IT/donna/designer/fendi" then
            vip_fendi_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/fendi.html?page=1" then
            vip_fendi_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/fendi.html" then
            moncler_vip_man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end
