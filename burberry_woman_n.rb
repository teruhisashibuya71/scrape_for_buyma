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
require './dante5'
require './labels'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'


class NormalWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby burberry_woman_n.rb
    @category = "靴"
    @price = "490"
    
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
    include Smets
    include Vietti
    
    #selenium
    include Bernardelli
    include Credoman
    include Dante5
    include Genteroma
    include Labels
    include Ottodisapietro
    include Papini
    include Plline
    include Spinnaker

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end             m

ATTACK_LIST_URL = [
    
    #以下selenium
    #"https://www.graphiti.fr/17_burberry/s-9/public-femme"

]


    _n_woman = NormalWoman.new
    @price = NormalWoman.call_price
    @category = NormalWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when 
            _n_woman.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _n_woman.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")  
        when 
            _n_woman.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _n_woman.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            _n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _n_woman.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _n_woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            _n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            _n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _n_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when 
            _n_woman.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無
        when 
            _normal_man.dante5_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when 
            _n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            _n_woman.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when 
            _n_woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            _n_woman.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when 
            _n_woman.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when 
            _n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        end
    end



#nokogiri系
https://www.aldogibilaro.com/en/brands
https://www.capsulebyeso.com/en/brand.html
https://www.corteccisiena.it/shop/home
https://www.ekseption.com/ot_es/designers?___store=ot_es&___from_store=ot_en
https://grifo210.com/en/designers-woman
https://www.lidiashopping.com/en/IT/women/designers
https://www.julian-fashion.com/en-IT/women/designers
https://www.luisaworld.com/womens-designers/
https://www.mycompanero.com/fr/
https://smets.lu/pages/brands-women
https://www.viettishop.com/it/designers/


#selenium
https://www.bernardellistores.com/it/brands#woman
https://www.dante5.com/it-IT/donna/designers
https://www.genteroma.com/it/designers/gender/female/
https://shop.labelsfashion.com/women/designers
https://www.ottodisanpietro.com/eu_en/woman-fashion/woman-designers
https://www.papinistore.com/designers
https://www.pl-line.com/en/brands
https://www.spinnakerboutique.com/it-IT/donna/designers











https://www.agnettiboutique.it/eu/brands-woman

https://www.antonia.it/it/brands?category=4

https://www.frmoda.com/en/designer/golden-goose
https://www.flanella.com/collections/woman

https://www.ceneregb.com/en/woman/designers
https://www.chirullishop.com/it/brands

https://www.divincenzoboutique.com/en/women/designers
https://www.dante5.com/it-IT/donna/designers

https://shop.jofre.eu/pages/brands

https://www.matchesfashion.com/intl/womens/designers

https://www.parisricci.com/it/brands-woman

https://www.slamjam.com/en_IT/woman/brands

https://www.thedoublef.com/it_en/man/designers




UK
https://www.zeeandco.co.uk/womens/brands
