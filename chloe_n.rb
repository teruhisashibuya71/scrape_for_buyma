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



#https://bungalow.store/de/women/designer/chloe/
#https://www.instagram.com/ungerfashion/?hl=en
#https://www.unger-fashion.com/en/bags/shoulder-bags/50547/umhaengetasche-marcie-saddle-small-tan
#https://www.debijenkorf.nl/damesschoenen/chloe

#https://www.dante5.com/it-IT/donna/designer/chloe

class ChloeNormalWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby chloe_n.rb
    @category = "バッグ"
    @price = "1090"
    
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

end

ATTACK_LIST_URL = [
    #現在商品無し "https://www.capsulebyeso.com/en/women-chloe#"
    "https://www.ekseption.com/ot_en/designers/chloe",
    "https://grifo210.com/it/catalog/category/view/s/chloe/id/366/?sale=0",
    "https://www.julian-fashion.com/en-IT/women/designer/chloe",
    "https://www.luisaworld.com/womens-designers/chloe/",
    "https://smets.lu/collections/chloe",
    #"https://www.viettishop.com/it/designers/chloe",
    
    ##以下selenium
    "https://www.genteroma.com/it/designer/donna/chloe.html",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/chloe",
    "https://www.papinistore.com/it/84_chloe"
]

    chloe_n_woman = ChloeNormalWoman.new
    @price = ChloeNormalWoman.call_price
    @category = ChloeNormalWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        #when "capsel"
        #    chloe_n_woman.capsel_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")  
        when "https://www.ekseption.com/ot_en/designers/chloe"
            chloe_n_woman.ekseption_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://grifo210.com/it/catalog/category/view/s/chloe/id/366/?sale=0"
            chloe_n_woman.grifo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.julian-fashion.com/en-IT/women/designer/chloe"
            chloe_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/womens-designers/chloe/"
            chloe_n_woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        #when "muconpanero" 商品消えた
        #    chloe_n_woman.mycompanero_crawl(attack_site_url, @price)
        #    @price = @price.delete(",")
        when "https://smets.lu/collections/chloe"
            chloe_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.viettishop.com/it/designers/chloe"
            chloe_n_woman.vietti_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.genteroma.com/it/designer/donna/chloe.html"
            chloe_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.papinistore.com/it/84_chloe"
            chloe_n_woman.papini_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
        when "https://www.spinnakerboutique.com/it-IT/donna/designer/chloe"
            chloe_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し 
        end
    end


#https://www.breuninger.com/de/marken/chloe/sneaker-lauren/1001265624/p/
#https://www.coltortiboutique.com/en_gb/sneakers-chloe-211512nsn000003-26c.html
#https://www.fashionette.co.uk/chloe-lauren-lace-sneakers-pink-tea
#https://www.fwrd.com/product-chloe-lauren-lace-sneakers-in-pink-tea/CLOE-WZ311/?d=Womens&source=cj&AID=13323577&PID=7664086&utm_medium=affiliate&utm_source=cj&utm_campaign=glob_p_2918733&cjevent=fd8c135c5cdc11ec815e2b060a1c0e0d
#https://alicewow.com/product/chloe-lauren-lace-sneakers/
#https://modesens.com/product/chloe-exclusive-to-mytheresa---lauren-lace-sneakers-pink-tea-17528359/
#https://www.bloomingdales.com/shop/product/chloe-womens-lauren-lace-low-top-sneakers?ID=3236253&utm_source=rakuten&utm_medium=affiliate&utm_campaign=affiliates&ranMID=13867&ranEAID=z1KL9yrNyf4&ranSiteID=z1KL9yrNyf4-7YF2uSYbFb_eT0UL0tJK.Q&LinkshareID=z1KL9yrNyf4-7YF2uSYbFb_eT0UL0tJK.Q&m_sc=aff&PartnerID=LINKSHARE&cm_mmc=LINKSHARE-_-n-_-n-_-n&ranPublisherID=z1KL9yrNyf4&ranLinkID=1&ranLinkTypeID=10&pubNAME=ModeSens#modesens=1
#https://www.24s.com/en-jp/lauren-trainers-chloe_CHL633V2PINSI37000
#https://www.fwrd.com/product-chloe-lauren-lace-sneakers-in-pink-tea/CLOE-WZ311/?AID=12150991&PID=7902150&utm_medium=affiliate&utm_source=cj&source=cj&utm_campaign=glob_p_4611097&cjevent=01b6f8a05cdd11ec83ba00610a1c0e13#modesens=1
#https://www.farfetch.com/shopping/women/chloe-lauren-low-top-sneakers-item-15592302.aspx?fsb=1&clickref=1011liEfVbJb&utm_source=modesens&utm_medium=affiliate&utm_campaign=PHUS&utm_term=USNetwork&pid=performancehorizon_int&c=modesens&clickid=1011liEfVbJb&af_siteid=1100l16177&af_sub_siteid=1011l270&af_cost_model=CPA&af_channel=affiliate&is_retargeting=true#modesens=1
#https://www.mytheresa.com/en-us/catalog/product/view/id/1401822/s/chloe-exclusive-to-mytheresa-lauren-lace-sneakers-1401822/?lpcr=pdptrecoaff&utm_source=affiliate&utm_medium=affiliate.linkshare.uk&ranMID=35663&ranEAID=z1KL9yrNyf4&ranSiteID=z1KL9yrNyf4-TK2fFg53fRbT2I5CQCBGTg#modesens=1&slink=1
#https://www.chloe.com/nl/sneakers_cod11912664wf.html
#https://www.luxuryfashionstores.sk/en/64686/chloe-chc19u108d2-lauren-sneakers_p
#https://www.cettire.com/products/chlo-lauren-lace-sneakers-95987391?variant=39300842193009&gclid=Cj0KCQiAnuGNBhCPARIsACbnLzpTHoAAErcDXqvpMr7iDQYnIeW0UX_x0opw2h1QluQvNO4-RTQtCXEaAiekEALw_wcB
#https://www.baseblu.com/en/sneakers/49815-sneakers.html?SubmitCurrency=1&id_currency=12&gclid=Cj0KCQiAnuGNBhCPARIsACbnLzriXLfMG2IK9U4lOP_iQ5B_mApb04Rzzu8JXkX2MgZ7Hg8gnWo9LCQaAmPdEALw_wcB
