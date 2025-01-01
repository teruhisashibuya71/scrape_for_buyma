require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'
#UK
#https://www.garmentquarter.com/alexander-mcqueen/mens
#https://www.vanmildert.com/alexander-mcqueen#dcp=1&dppp=99&OrderBy=recent&Filter=AFLOR%5EMens
#https://www.zapclothing.com/designers/alexander-mcqueen
#https://www.eleganza-shop.com/designers/alexander-mcqueen?page=1&geslacht%5Bfilter%5D=Men%2C415
#https://www.lagrange12.com/en_eu/men/designers/alexander-mcqueen.html?macrocategory=SHOES

class AmacNormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby amac_man_n.rb
    @category = "靴"
    @price = "550"
    @currency = 143.3
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti
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
    "https://www.capsulebyeso.com/en/men-alexander+mcqueen",
    "https://grifo210.com/en/catalog/category/view/s/alexander-mcqueen/id/374/?sale=0",
    "https://www.julian-fashion.com/en-IT/men/designer/alexander_mcqueen",
    "https://www.ilduomo.it/designer/alexander-mcqueen.html?gender=man&resultsPerPage=2000&order=product.date_add.desc",
    "https://www.luisaworld.com/product-category/man/?product_brand=alexander-mcqueen",
    "https://www.mycompanero.com/fr/brand/33-alexander-mcqueen?categories=homme",
    "https://smets.lu/collections/alexander-mcqueen/men",
    "https://www.viettishop.com/it/designers/alexander-mcqueen?cat=462",

    #以下selenium
    "https://www.credomen.com/alexandermcqueen/",
    "https://www.dante5.com/it-IT/uomo/designer/alexander_mcqueen",
    "https://www.genteroma.com/it/designer/uomo/alexander-mcqueen.html",
    "https://shop.labelsfashion.com/men/designers/alexander-mcqueen",
    "https://www.spinnakerboutique.com/it-IT/uomo/designer/alexander_mcqueen"

]

amac_n_man = AmacNormalMan.new
@price = AmacNormalMan.call_price
@category = AmacNormalMan.call_category
@currency = AmacNormalMan.call_currency

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.capsulebyeso.com/en/men-alexander+mcqueen"
        amac_n_man.capsel_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://grifo210.com/en/catalog/category/view/s/alexander-mcqueen/id/374/?sale=0"
        amac_n_man.grifo_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.julian-fashion.com/en-IT/men/designer/alexander_mcqueen"
        amac_n_man.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.ilduomo.it/designer/alexander-mcqueen.html?gender=man&resultsPerPage=2000&order=product.date_add.desc"
        amac_n_man.ilduomo_crawl(attack_site_url, @price, @currnecy)
        #日本円調整のため小数点調整 無し
    when "https://www.luisaworld.com/product-category/man/?product_brand=alexander-mcqueen"
        amac_n_man.luisa_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.mycompanero.com/fr/brand/33-alexander-mcqueen?categories=homme"
        amac_n_man.mycompanero_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://smets.lu/collections/alexander-mcqueen/men"
        amac_n_man.smets_crawl(attack_site_url, @price)
        #@price = @price.delete(".") #価格内部のドットとコンマの調整はしない事とした (2023/01/21)
    when "https://www.viettishop.com/it/designers/alexander-mcqueen?cat=462"
        amac_n_man.vietti_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    
    #以下selenium
    when "https://www.credomen.com/alexandermcqueen/"
        amac_n_man.credoman_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.dante5.com/it-IT/uomo/designer/alexander_mcqueen"
        amac_n_man.dante5_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.genteroma.com/it/designer/uomo/alexander-mcqueen.html"
        amac_n_man.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://shop.labelsfashion.com/men/designers/alexander-mcqueen"
        amac_n_man.labels_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.spinnakerboutique.com/it-IT/uomo/designer/alexander_mcqueen"
        amac_n_man.spinnnaker_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    end
end