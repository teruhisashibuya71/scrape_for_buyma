#いちよう完成! 9月12日

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


#require ./ファイル名
require './amr'
require './coltorti_woman'
require './gaudenzi'
require './leam'
require './michelef'
require './nugnes'
require './russocapri'
require './suit'
require './tessabit'

#selenium系
require './alducadaosta'
require './brunarosso_woman'
require './blondie'
require './monti'
require './tessabit'


class MaxmaraVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "398"

    include Amr
    include ColtortiWoman
    include Gaudenzi
    include Leam
    include Nugnes
    include Russocapri
    include Suit
    include Tessabit

    #seleniumm系
    include Alducadaosta
    include BrunarossoWoman
    include Blondie
    include Monti
    include Tessabit


    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    #"https://amrstore.com/collections/max-mara",
    #"https://www.coltortiboutique.com/it/designer/max_mara?cat=166",    
    #"https://www.gaudenziboutique.com/en-it/women/designer/max_mara",
    #"https://www.leam.com/en_en/designer/max-mara-women.html",
    #"https://nugnes1920.com/collections/max-mara-woman",
    #"https://www.russocapri.com/en/all/designer/max-mara/groups",
    #"https://suitnegozi.com/collections/max-mara-donna?custom_sort_by=created-descending&pagination=1&page=1",
    
    #selenium
    "https://www.alducadaosta.com/it/donna/designer/max_mara",
    "https://www.brunarosso.com/s/designers/max-mara/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/max-mara.html",
    "https://www.montiboutique.com/it-IT/Donna/designer/max_mara",
    "https://www.tessabit.com/it_it/donna/designers/max-mara.html?page=1"

    #MaxMaraStudio
    #"https://www.michelefranzesemoda.com/it/donna/designer/maxmara-studio/",
]

    vip_mara_woman = MaxmaraVipWoman.new
    @price = MaxmaraVipWoman.call_price
    @category = MaxmaraVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/max-mara" then
            vip_mara_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/max_mara?cat=166" then
            vip_mara_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/max_mara" then
            vip_mara_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en_en/designer/max-mara-women.html" then
            vip_mara_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/max-mara-woman" then
            vip_mara_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/en/all/designer/max-mara/groups" then
            vip_mara_woman.russo_crawl(attack_site_url, @price)
        when "https://suitnegozi.com/collections/max-mara-donna?custom_sort_by=created-descending&pagination=1&page=1" then
            vip_mara_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/donna/designer/max_mara" then
            vip_mara_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/max-mara/?category=women" then
            vip_mara_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/max-mara.html"
            vip_mara_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/max_mara" then
            vip_mara_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/max-mara.html?page=1"
            vip_mara_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")

        #MamMaraStudio
        when "https://www.michelefranzesemoda.com/it/donna/designer/maxmara-studio/"
            vip_mara_woman.michele_crawl(attack_site_url, @price)
            #価格調整無し

        end
    end

