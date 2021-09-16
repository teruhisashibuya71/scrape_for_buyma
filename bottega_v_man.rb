#require './ファイル名'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

require './alducadaosta'
require './suit'
require './tessabit'
require './coltorti'
require './nugnes'
require './gaudenzi'
require './wise'
require './brunarosso_woman'
require './gb'
require './monti'
#require './eleonorabonucci'
require './auzmendi_f_woman'
require './russocapri'
require './sigrun'



class BottegaVipWoman
    #include + クラス名
    include Alducadaosta
    include Suit
    include Tessabit
    include Coltorti
    include Gb
    include Russocapri
    include Nugnes
    include Gaudenzi
    include Wise
    include BrunarossoWoman
    include Monti
    #include Eleonorabonucci
    include AuzmendiFarfetchWoman
    include SigrunWoehr

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "アクセ"
    @price = "320"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.alducadaosta.com/it/donna/designer/marni",
    "https://www.gebnegozionline.com/it_it/donna/designers/marni.html",
    "https://www.brunarosso.com/s/designers/marni/?category=women",
    "https://www.coltortiboutique.com/it/designer/marni_accessori?cat=166",
    "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=marni",
    "https://www.sigrun-woehr.com/en/By-Brand/Marni/",
    "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&sort=2&scale=274&designer=4224",
    "https://nugnes1920.com/collections/marni-woman",
    "https://www.montiboutique.com/it-IT/donna/designer/marni",
    "https://www.gaudenziboutique.com/en-it/women/designer/marni"
    "https://www.wiseboutique.com/it_it/donna/designers/marni.html"
    #"eleonorabonucci"
    ]

    vip_marni_woman = MarniVipWoman.new
    @price = MarniVipWoman.call_price
    @category = MarniVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.alducadaosta.com/it/donna/designer/marni" then
            vip_marni_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/marni/?category=women" then
            vip_marni_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #商品価格はそのまま
        when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=marni" then
            vip_marni_woman.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/marni_accessori?cat=166" then
            vip_marni_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Marni/" then
            vip_marni_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&sort=2&scale=274&designer=4224" then
            vip_marni_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/marni-woman" then
            vip_marni_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/marni" then
            vip_marni_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/marni" then
            vip_marni_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/marni.html" then
            vip_marni_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")        
        end
    end
