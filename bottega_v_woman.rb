#require './ファイル名'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


require './gb_f_woman'
require './coltorti'
require './tessabit'
require './sigrun'
require './suit'
require './leam'
require './nugnes'
require './alducadaosta'
require './gaudenzi'
require './amr_f_woman'
require './eleonorabonucci_f_woman'


#selenium
require './brunarosso_woman'
require './monti'
#require './eleonorabonucci'


#ひとまず完成
class BottegaVipWoman
    
    #include + クラス名
    include GbFarfetchWoman
    include Coltorti
    include Tessabit
    include SigrunWoehr
    include Suit
    include Leam
    include Nugnes
    include Alducadaosta
    include Gaudenzi
    include AmrFarfetchWoman
    include EleonorabonucciFarfetchWoman
    
    #selenium
    include BrunarossoWoman
    include Monti

    #include Eleonorabonucci


    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "950"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=19047",
    "https://www.coltortiboutique.com/it/designer/bottega_veneta?cat=166",
    "https://www.tessabit.com/it/en/woman/designers/bottega-veneta",
    "https://www.sigrun-woehr.com/en/By-Brand/Bottega-Veneta/",
    "https://suitnegozi.com/collections/bottega-veneta-donna",
    "https://www.leam.com/it_eu/designer/bottega-veneta-women.html",
    "https://nugnes1920.com/collections/bottega-veneta-woman",
    "https://www.alducadaosta.com/it/donna/designer/bottega_veneta",
    "https://www.gaudenziboutique.com/en-it/women/designer/bottega_veneta",
    "https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&designer=19047",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&designer=19047",
    "https://www.montiboutique.com/en-US/women/designer/bottega_veneta",
    "https://www.brunarosso.com/s/designers/bottega-veneta/?category=women"
    ]

    vip_bottega_woman = BottegaVipWoman.new
    @price = BottegaVipWoman.call_price
    @category = BottegaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=19047" then
            vip_bottega_woman.gbfarfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/bottega_veneta?cat=166" then
            vip_bottega_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/en/woman/designers/bottega-veneta" then
            vip_bottega_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Bottega-Veneta/" then
            vip_bottega_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/bottega-veneta-donna" then
            vip_bottega_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/bottega-veneta-women.html" then
            vip_bottega_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/bottega-veneta-woman" then
            vip_bottega_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.alducadaosta.com/it/donna/designer/bottega_veneta" then
            vip_bottega_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/bottega_veneta" then
            vip_bottega_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&designer=19047" then
            vip_bottega_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&designer=19047" then
            vip_bottega_woman.elenora_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/bottega_veneta" then
            vip_bottega_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/bottega/?category=women" then
            vip_bottega_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #商品価格はそのまま
        end
    end
