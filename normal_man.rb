require 'rubygems'
require 'nokogiri'
require 'open-uri'

#./'ファイル名'
require './aldogibilaro'
require './capsel'
require './cortecci'
require './ekseption'
require './grifo'
require './julian'
require './lidia'
require './luisa_world'
require './mycompanero'
require './ottodisapietro'
require './smets'
require './vietti'

#以下selenium
require './bernardelli'
require './credoman'
require './labels'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'


class OOOONormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "800"
    
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
    include Bernardelli
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
    "aldogibilallo",
    "capsel",
    "cortecci",
    "ekseption",
    "grifo",
    "julian",
    "lidia",
    "luisaworld",
    "mucompanero",
    "smets",
    "vietti",
    
    #以下selenium
    "bernardelli",
    "credoman",
    "genteroma",
    "labels",
    "papini",
    "spinnsker",
    "pl-line"
]

    moncler_n_man = MonclerNormalMan.new
    @price = MonclerNormalMan.call_price
    @category = MonclerNormalMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "aldogibilallo"
            moncler_n_man.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")   
        when "capsel"
            moncler_n_man.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "cortecci"
            moncler_n_man.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "ekseption"
            moncler_n_man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "grifo"
            moncler_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "lidia"
            moncler_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "julian"
            moncler_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "luisaworld"
            moncler_n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "mycompanero"
            moncler_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "smets"
            moncler_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "vietti"
            moncler_n_man.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "bernaldi"
            moncler_n_man.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "credoman"
            moncler_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "gente"
            moncler_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "labels"
            moncler_n_man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "otto"
            moncler_n_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "papini"
            moncler_n_man.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "pl"
            moncler_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "spin"
            moncler_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        end
    end


#nokogiri
https://www.aldogibilaro.com/en/brands
https://www.capsulebyeso.com/en/brand.html
https://www.corteccisiena.it/shop/home
https://www.ekseption.com/ot_es/designers?___store=ot_es&___from_store=ot_en
https://grifo210.com/iit/
https://www.lidiashopping.com/en/IT/men/designers
https://www.julian-fashion.com/en-IT/men/designers
https://www.luisaworld.com/mens-designers/
https://www.mycompanero.com/fr/
https://smets.lu/pages/brands-men
https://www.viettishop.com/it/designers/



#selenium
https://www.bernardellistores.com/it/brands#men
https://www.credomen.com/
https://www.genteroma.com/it/designers/gender/male/
https://shop.labelsfashion.com/men/designers
https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers
https://www.papinistore.com/designers
https://www.pl-line.com/en/brands
https://www.spinnakerboutique.com/it-IT/uomo/designers





https://www.agnettiboutique.it/eu/brands-man
https://www.aldogibilaro.com/en/brands
https://www.antonia.it/it/brands?category=3

https://www.bernardellistores.com/it/brands#men

https://www.capsulebyeso.com/en/brand.html
https://www.ceneregb.com/en/man/designers
https://www.chirullishop.com/it/brands
https://www.corteccisiena.it/shop/home
https://www.credomen.com/

https://www.dante5.com/it-IT/uomo/designers
https://www.divincenzoboutique.com/en/men/designers

https://www.ekseption.com/ot_es/designers?___store=ot_es&___from_store=ot_en

https://www.frmoda.com/en/designer
https://www.flanella.com/collections/man

https://www.genteroma.com/it/designers/gender/male/
https://grifo210.com/iit/

https://www.lidiashopping.com/en/IT/men/designers
https://shop.jofre.eu/pages/brands
https://www.julian-fashion.com/en-IT/men/designers

https://shop.labelsfashion.com/men/designers
https://www.luisaworld.com/mens-designers/

https://www.mycompanero.com/fr/

https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers

https://www.papinistore.com/designers
https://www.parisricci.com/it/brands-man
https://www.pl-line.com/en/brands

https://smets.lu/pages/brands-men

https://www.slamjam.com/en_IT/man/brands
https://www.spinnakerboutique.it/en/manufacturer/all


https://www.viettishop.com/it/designers/




UK
https://www.brother2brother.com/brands #man only
https://www.zeeandco.co.uk/mens/brands
https://www.zoofashions.com/pages/designers