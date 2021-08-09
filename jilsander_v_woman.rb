require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

require './gb'
require './brunarosso_f_woman'
require './coltorti'
require './blondie_f_woman'
require './russocapri'
require './suit'
require './wise'
require './leam'
require './nugnes'
require './actuelb'
require './gaudenzi'
require './eleonorabonucci_f_woman'


#残りタスク1
#blondie オリジナルサイト farfetchにJIL SANDER表示ない
#https://www.blondieshop.com/it/woman/woman-designer/jil-sander.html


class JilsanderVipWoman

    #include + クラス名
    include Gb
    include BrunarossoFarfetchWoman
    include Coltorti
    include BlondieFarfetchWoman
    include Russocapri
    include Suit
    include Wise
    include Leam
    include Nugnes
    include Actuelb
    include Gaudenzi
    include EleonorabonucciFarfetchWoman
    

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "495"
    #vip_jilsander_woman = FendiVipWoman.new

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [#"https://www.gebnegozionline.com/it_it/donna/designers/jil-sander.html",
                   #"https://www.farfetch.com/it/shopping/women/bruna-rosso/items.aspx?view=90&scale=274&designer=3066",
                   #"https://www.coltortiboutique.com/it/designer/jil_sander?cat=166",
                   ##"https://www.blondieshop.com/it/woman/woman-designer/jil-sander.html"
                   #"https://www.russocapri.com/it/tutti/designer/jil-sander/gruppi",
                   #"https://suitnegozi.com/collections/jil-sander-donna",
                   #"https://www.wiseboutique.com/it_it/donna/designers/jil-sander.html"
                   #"https://www.leam.com/it_eu/designer/jil-sander-donna.html",
                   #"https://nugnes1920.com/collections/jil-sander-woman",
                   "https://actuelb.com/en/496-women-s-jil-sander",
                   #"https://www.gaudenziboutique.com/en-it/women/designer/jil_sander",
                   #"https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&designer=3066"
                   ]

    vip_jilsander_woman = JilsanderVipWoman.new
    @price = JilsanderVipWoman.call_price
    @category = JilsanderVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.gebnegozionline.com/it_it/donna/designers/jil-sander.html" then
            vip_jilsander_woman.gb_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/bruna-rosso/items.aspx?view=90&scale=274&designer=3066" then
            vip_jilsander_woman.bruna_farfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/jil_sander?cat=166" then
            vip_jilsander_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "https://www.coltortiboutique.com/it/designer/fendi?cat=166" then
        #    vip_jilsander_woman.coltorti_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        when "https://www.russocapri.com/it/tutti/designer/jil-sander/gruppi" then
            vip_jilsander_woman.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/jil-sander-donna" then
            vip_jilsander_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.wiseboutique.com/it_it/donna/designers/jil-sander.html" then
            vip_jilsander_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.leam.com/it_eu/designer/jil-sander-donna.html" then
            vip_jilsander_woman.leam_crawl(attack_site_url)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/jil-sander-woman" then
            vip_jilsander_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://actuelb.com/en/496-women-s-jil-sander" then
            vip_jilsander_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")   
        when "https://www.gaudenziboutique.com/en-it/women/designer/jil_sander" then
            vip_jilsander_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&designer=3066" then
            vip_jilsander_woman.elenora_farfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        end
    end
