require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

class FendiNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby fendi_man_n.rb
    @category = "靴"
    @price = "795"
    
    #include + クラス名
    include Aldogibilaro
    include Capsel
    include Cortecci
    include Ekseption
    include Grifo
    include Julian #0サイズあるよ
    include Lidia
    include LuisaWorld
    include Mycompanero
    include Ottodisapietro
    include Smets
    include Vietti
    
    #selenium
    include Credoman
    include Genteroma
    include Labels
    include Papini
    include Plline
    include Spinnaker
    
    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    #"https://www.aldogibilaro.com/en/10000064_fendi",
    # ブランド消えた"https://www.ekseption.com/ot_en/designers/fendi?cat=84",
    "https://grifo210.com/en/catalog/category/view/s/fendi/id/351/?sale=",
    "https://www.julian-fashion.com/en-IT/men/designer/fendi",
    "https://www.luisaworld.com/product-category/man/?product_brand=fendi",
    "https://www.mycompanero.com/fr/brand/41-fendi?categories=homme",
    "https://smets.lu/collections/fendi/men+no-sale",

    #以下selenium
    "https://www.spinnakerboutique.com/it-IT/uomo/designer/fendi",
    #"https://www.papinistore.com/en/24_fendi"
]

    fendi_n_man = FendiNormalMan.new
    @price = FendiNormalMan.call_price
    @category = FendiNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.aldogibilaro.com/en/10000064_fendi"
            fendi_n_man.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")   
        #when "https://www.ekseption.com/ot_en/designers/fendi?cat=84"
        #    fendi_n_man.ekseption_crawl(attack_site_url, @price)
        #    @price = @price.delete(",")
        when "https://grifo210.com/en/catalog/category/view/s/fendi/id/351/?sale="
            fendi_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #when "https://www.julian-fashion.com/en-IT/men/designer/fendi",
        #    fendi_n_man.julian_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        when "https://www.luisaworld.com/product-category/man/?product_brand=fendi"
            fendi_n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/brand/41-fendi?categories=hommes"
            fendi_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://smets.lu/collections/fendi/men+no-sale"
            fendi_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.papinistore.com/en/24_fendi"
            fendi_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.com/it-IT/uomo/designer/fendi"
            fendi_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end


#https://www.nidacaserta.it/en/man/designer/fendi/groups
#https://www.pozzilei.it/fendi