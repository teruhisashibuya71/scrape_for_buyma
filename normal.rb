require './broken-arm'
require './cortecci'
require './ekseption'
require './grifo'
require './lidia'
require './luisa_world'
require './julian'
require './mycompanero'
require './smets'
require './vietti'


#selenium
require './bernardelli'
require './credoman'
require './labels'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'


class NormalMan
    
    #require ./ファイル名
    include Brokenarm
    include Cortecci
    include Ekseption
    include Grifo
    include Lidia
    include LuisaWorld
    include Julian
    include Mycompanero
    include Smets
    include Vietti
    

    #selenium系    
    include Bernardelli
    include Credoman
    include Labels
    include Genteroma
    include Papini
    include Pl_line
    include Spinnaker


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
    "brokenarm",
    "cortessi",
    "ekseption",
    "grifo210",
    "lidia",
    "luisaworld",
    "https://www.julian-fashion.com/it-IT/uomo/designer/marni",
    "myconpanero",
    "smets",
    "viettti",
    #以下selenium
    "https://www.bernardellistores.com/it/uomo/marni?order=LATEST",
    "credo",
    "labels",
    "genteroma",
    "papini",
    "Pl_line",
    "spinnaker",
    ]


    normal_marini_man = MarniNormalMan.new
    @price = MarniNormalMan.call_price
    @category = MarniNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url

        when "broken-arm" then
            normal_marini_man.cortecci_crawl(brand_home_url, search_price)
            @price = @price.delete(".")


        when "cortessi" then
            normal_marini_man.cortecci_crawl(brand_home_url, search_price)
            @price = @price.delete(".")
        when "ekseption" then
            normal_marini_man.ekseption_crawl(brand_home_url, search_price)
            @price = @price.delete(".")
        when "grifo" then
            normal_marini_man.grifo_crawl(brand_home_url, search_price)
            @price = @price.delete(".")
        when "lidia" then
            normal_marini_man.lidia_crawl(brand_home_url, search_price)
            @price = @price.delete(".")
        when "luisaWorld" then
            normal_marini_man.luisa_crawl(brand_home_url, search_price)
            @price = @price.delete(",")
        when "julian" then
            normal_marini_man.julian_crawl(attack_site_url, @price)            
            @price = @price.delete(".")
        when "companero" then
            normal_marini_man.mycompanero_crawl(attack_site_url, @price)            
            @price = @price.delete(",")
        when "smets" then
            normal_marini_man.mycompanero_crawl(attack_site_url, @price)            
            @price = @price.delete(".")
        when "vietti" then
            normal_marini_man.vietti_crawl(attack_site_url, @price)            
            @price = @price.delete(".")
        
            #以下selenium
        when "Bernardelli store" then
            normal_marini_man.bernardelli_crawl_selenium(attack_site_url, @price)            
            #商品価格の桁数調整無し
        when "credo" then
            normal_marini_man.credoman_crawl_selenium(attack_site_url, @price)            
            @price = @price.delete(".")
        when "genteroma" then
            normal_marini_man.vietti_crawl(attack_site_url, @price)            
            @price = @price.delete(".")
        when "https://www.papinistore.com/designers" then
            normal_marini_man.vietti_crawl(attack_site_url, @price)            
            @price = @price.delete(".")
        when "pl-line" then
            normal_marini_man.plline_crawl_selenium(attack_site_url, @price)            
            #商品価価格桁数調整無し
        when "labels" then
            normal_marini_man.vietti_crawl(attack_site_url, @price)            
            #商品価価格桁数調整無し
        when "spinnaker" then
            normal_marini_man.vietti_crawl(attack_site_url, @price)            
            @price = @price.delete(".")
        end
    end



