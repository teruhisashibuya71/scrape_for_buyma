require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#ilduomoまで改修済み 1/15
class RickNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "800"
    @currency = 
    #include + クラス名
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti, WrongWeather
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
    def self.call_currency
        @currency
    end
end

ATTACK_LIST_URL = [

    #italiani
    https://www.farfetch.com/it/shopping/men/italiani/items.aspx?view=90&designer=3060
    https://www.julian-fashion.com/en-IT/men/designer/rick_owens
    https://smets.lu/collections/rick-owens
    https://www.wrongweather.net/jp/shop/brand/rick-owens?page=2

    #selenium
    "https://www.wrongweather.net/it/shop/brand/rick-owens"
    #"https://www.graphiti.fr/brand/226-rick-owens"
    
ilduomo

https://www.10corsocomo-theshoponline.com/ita_en/brand/rick-owens-man


https://labelsfashion.com/collections/men-rick-owens
https://labelsfashion.com/collections/men-rick-owens-drkshdw



    #以下selenium
    https://www.bernardellistores.com/it/rick-owens-drkshdw
    https://www.genteroma.com/it/designer/uomo/rick-owens.html
    https://labelsfashion.com/collections/men-rick-owens

    https://www.equipeboutique.it/en/man#/manFilters=12&pageSize=24&viewMode=grid&orderBy=15&pageNumber=1
    
    
    #darkshadow
    #italiani
    https://www.farfetch.com/it/shopping/men/italiani/items.aspx?page=1&view=90&sort=3&scale=282&designer=4752
    https://www.bernardellistores.com/it/rick-owens

    https://www.equipeboutique.it/en/man#/manFilters=13&pageSize=24&viewMode=grid&orderBy=15&pageNumber=1
    https://www.genteroma.com/us/designer/man/rick-owens-drkshdw.html
    https://labelsfashion.com/collections/men-rick-owens-drkshdw
]

    rick_n_man = RickNormalMan.new
    @price = RickNormalMan.call_price
    @category = RickNormalMan.call_category
    @ccurrency = NormalWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when ""
            rick_n_man.aldogibilaro_crawl(attack_site_url, @price)
            @price = @price.delete(".")   
        when ""
            rick_n_man.capsel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            rick_n_man.cortecci_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            rick_n_man.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            rick_n_man.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            rick_n_man.ilduomo_crawl(attack_site_url, @price, @currnecy)
            #日本円調整のため小数点調整 無し
        when ""
            rick_n_man.lidia_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            rick_n_man.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            rick_n_man.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            rick_n_man.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            rick_n_man.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            rick_n_man.vietti_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when ""
            rick_n_man.bernardelli_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when ""
            rick_n_man.credoman_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when ""
            rick_n_man.dante5_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when ""
            rick_n_man.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            rick_n_man.labels_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when ""
            rick_n_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            rick_n_man.papini_crawl_selenium(attack_site_url, @price, @currency)
            #小数点削除必要無し
        when ""
            rick_n_man.plline_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when ""
            rick_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.wrongweather.net/it/shop/brand/rick-owens"
            rick_n_man.wrong_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        
        #farfetch
        when ""
            rick_n_man.farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        end
    end


    https://aleluyabcn.com/products/jersey-trucker-cut-offs

#nokogiri系
https://www.aldogibilaro.com/en/brands
https://www.capsulebyeso.com/en/brand.html
https://www.corteccisiena.it/shop/home
https://www.ekseption.com/ot_es/designers?___store=ot_es&___from_store=ot_en
https://grifo210.com/en/designers-man
https://www.lidiashopping.com/en/IT/men/designers
https://www.julian-fashion.com/en-IT/men/designers
https://www.luisaworld.com/mens-designers/
https://www.mycompanero.com/fr/
https://smets.lu/pages/brands-men
https://www.viettishop.com/it/designers/


#selenium
https://www.bernardellistores.com/it/brands#man
https://www.credomen.com/
https://www.dante5.com/it-IT/uomo/designers
https://www.genteroma.com/it/designers/gender/male/
https://shop.labelsfashion.com/men/designers
https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers
https://www.papinistore.com/designers
https://www.pl-line.com/en/brands
https://www.spinnakerboutique.com/it-IT/uomo/designers
https://plazafashionstore.com/brand/saint-laurent

https://marais.com.au/ja/collections/vendors?q=DARK%20SHADOW
https://www.18montrose.com/rick-owens#dcp=2&dppp=99&OrderBy=rank


https://www.insightconceptstore.com/it/uomo/designer/rick-owens.html
https://www.nibaweb.com/index.html

https://www.theapartmentcosenza.com/it-IT/uomo/designer/rick_owens
https://www.theapartmentcosenza.com/it-IT/uomo/designer/rick_owens_drkshdw

#spazio
#https://www.suus.es/product-tag/rick-owens/
#https://www.spaziopritelli.com/eu/rick-s-pod-23pru01c4384te-09.html
