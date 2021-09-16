require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'selenium-webdriver'

#require ./ファイル名
require './julian'


#selenium系
require './bernardelli'



class MarniNormalMan
    
    #require ./ファイル名
    include Julian
    

    #selenium系    
    include Bernardelli


    

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
    "https://www.julian-fashion.com/it-IT/uomo/designer/marni",
    #以下selenium
    "https://www.bernardellistores.com/it/uomo/marni?order=LATEST"
    ]

    normal_marini_man = MarniNormalMan.new
    @price = MarniNormalMan.call_price
    @category = MarniNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        # when "actuelb" then
        #     vip_stella_woman.actuel_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(",")
        #when "https://www.alducadaosta.com/it/donna/designer/stella_mccartney" then
        #    vip_stella_woman.alducadaosta_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        # when "auzmendi" then
        #     vip_stella_woman.auzumendi_f_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        #when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502" then
        #    vip_stella_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        #when "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166" then
        #    vip_stella_woman.coltorti_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        when "https://www.julian-fashion.com/it-IT/uomo/designer/marni" then
            normal_marini_man.julian_crawl(attack_site_url, @price)            
            @price = @price.delete(".")
        # when "gaudenzi" then
        #     vip_stella_woman.gaudenzi_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "https://www.leam.com/it_eu/designer/stella-mccartney-donna.html" then
        #     vip_stella_woman.leam_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")

        # when "https://www.leam.com/it_eu/designer/stella-mccartney-donna.html" then
        #     vip_stella_woman.leam_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        # when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney" then
        #     vip_stella_woman.russo_crawl(attack_site_url, @price)
        #     #価格調整無し
        # when "sigrun" then
        #     vip_stella_woman.sigrun_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        #when "https://suitnegozi.com/collections/stella-mccartney-donna" then
        #    vip_stella_woman.suit_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #when "https://www.tessabit.com/it/donna/designers/stella-mccartney" then
        #    vip_stella_woman.tessabit_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(",")
        # when "https://www.farfetch.com/it/shopping/women/wise-boutique/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502" then
        #     vip_stella_woman.wise_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
            #selenium
        when "https://www.bernardellistores.com/it/uomo/marni?order=LATEST" then
            normal_marini_man.bernardelli_crawl_selenium(attack_site_url, @price, @category)
            #桁調整無し
        #when "https://www.brunarosso.com/s/designers/stella-mccartney/?category=women" then
        #    vip_stella_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
        #    #別の変数に代入して使用しているため調整不要
        #when "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.html" then
        #    vip_stella_woman.blondie_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        # when "eleonorabonucci" then
        #     vip_stella_woman.elenora_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "gb" then
        #     vip_stella_woman.gb_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        #when "https://www.montiboutique.com/it-IT/Donna/designer/stella_mccartney" then
        #    vip_stella_woman.monti_crawl_selenium(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        end
    end



