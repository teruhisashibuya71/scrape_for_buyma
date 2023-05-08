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
require './wise_f_woman'


#selenium系
require './alducadaosta'
require './brunarosso_woman'
require './blondie'
require './eleonorabonucci'
require './gb'
require './monti'
require './tessabit'
require './wise'


class IsabelVip

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby isabel_v.rb
    @category = "バッグ"
    @price = "120"
    
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
    "https://amrstore.com/collections/isabel-marant",
    "https://www.coltortiboutique.com/it/designer/isabel_marant?cat=166",
    "https://www.coltortiboutique.com/it/designer/isabel_marant_etoile?cat=166",
    "https://www.gaudenziboutique.com/en-it/women/designer/isabel_marant",
    "https://www.gaudenziboutique.com/en-it/women/designer/isabel_marant_etoile",
    "https://nugnes1920.com/collections/isabel-marant-woman",
    "https://nugnes1920.com/collections/isabel-marant-etoile-woman",
    "https://www.sigrun-woehr.com/en/By-Brand/Isabel-Marant/",

    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/isabel_marant",
    "https://www.alducadaosta.com/it/donna/designer/isabel_marant_etoile",
    "https://eleonorabonucci.com/en/isabel-marant/women/new-collection",
    "https://eleonorabonucci.com/en/isabel-marant-etoile/women/new-collection",
    #"https://eleonorabonucci.com/en/isabel-marant/women/sale",
    #"https://eleonorabonucci.com/en/isabel-marant-etoile/women/sale",
    "https://www.gebnegozionline.com/it_it/donna/designers/isabel-marant.html",
    "https://www.gebnegozionline.com/it_it/donna/designers/isabel-marant-etoile.html",
    "https://www.montiboutique.com/it-IT/donna/designer/isabel_marant",
    "https://www.montiboutique.com/it-IT/donna/designer/isabel_marant_etoile",
    "https://www.tessabit.com/it_it/donna/designers/isabel-marant.html?page=1",
    "https://www.wiseboutique.com/it_it/donna/designers/isabel-marant-etoile.html",
    "https://www.blondieshop.com/it/donna/woman-designer/isabel-mccartney.htmls"
]

    vip_isabel_woman = IsabelVip.new
    @price = IsabelVip.call_price
    @category = IsabelVip.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/isabel-marant"
            vip_isabel_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/it/designer/isabel_mccartney?cat=166"
            vip_isabel_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/isabel_marant_etoile?cat=166"
            vip_isabel_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/isabel_marant" 
            vip_isabel_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/isabel_marant_etoile" 
            vip_isabel_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/isabel-marant-woman" 
            vip_isabel_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/isabel-marant-etoile-woman" 
            vip_isabel_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Isabel-Marant/" 
            vip_isabel_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.alducadaosta.com/it/donna/designer/isabel_marant" 
            vip_isabel_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.alducadaosta.com/it/donna/designer/isabel_marant_etoile" 
            vip_isabel_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/donna/woman-designer/isabel-mccartney.htmls" 
            vip_isabel_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/isabel-marant/women/new-collection" 
            vip_isabel_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/isabel-marant-etoile/women/new-collection" 
            vip_isabel_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        #when "#"https://eleonorabonucci.com/en/isabel-marant/women/sale"" 
        #    vip_isabel_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        #when "https://eleonorabonucci.com/en/isabel-marant-etoile/women/sale" 
        #    vip_isabel_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/isabel-marant.html" 
            vip_isabel_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/isabel-marant-etoile.html" 
            vip_isabel_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/isabel_marant" 
            vip_isabel_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/isabel_marant_etoile" 
            vip_isabel_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/isabel-marant.html?page=1" 
            vip_isabel_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/isabel-marant-etoile.html" 
            vip_isabel_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end

