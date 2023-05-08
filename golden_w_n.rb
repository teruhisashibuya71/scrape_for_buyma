require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#ilduomoまで改修済み 1/15
class GoldenNormalWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby golden_w_n.rb
    @category = "靴"
    @price = "455"
    @currency = 148.6
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Corsocomo, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti
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
    #nokogiri系
    "https://www.aldogibilaro.com/en/10000056_golden-goose-deluxe",
    "https://www.capsulebyeso.com/en/men-golden+goose+deluxe+brand",
    "https://www.ekseption.com/ot_en/designers/golden_goose_deluxe_brand",
    "https://www.ilduomo.it/designer/golden-goose.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc",
    "https://www.julian-fashion.com/en-IT/women/designer/golden_goose",
    "https://viettishop.com/it/collections/golden-goose/women",
    ##selenium
    "https://www.bernardellistores.com/it/golden-goose",
    "https://www.dante5.com/it-IT/donna/designer/golden_goose_deluxe_brand",
    "https://www.genteroma.com/it/designer/donna/golden-goose.html",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/golden_goose"
]
golden_n_woman = GoldenNormalWoman.new
@price = GoldenNormalWoman.call_price
@category = GoldenNormalWoman.call_category
@currency = GoldenNormalWoman.call_currency

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.aldogibilaro.com/en/10000056_golden-goose-deluxe"
        golden_n_woman.aldogibilaro_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.capsulebyeso.com/en/men-golden+goose+deluxe+brand"
        golden_n_woman.capsel_crawl(attack_site_url, @price)
        @price = @price.delete(".")  
    when "https://www.ekseption.com/ot_en/designers/golden_goose_deluxe_brand"
        golden_n_woman.ekseption_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.ilduomo.it/designer/golden-goose.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc"
        golden_n_woman.ilduomo_crawl(attack_site_url, @price, @currency)
        #日本円調整のため小数点調整 無し
    when "https://www.julian-fashion.com/en-IT/women/designer/golden_goose"
        golden_n_woman.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://viettishop.com/it/collections/golden-goose/women"
        golden_n_woman.vietti_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    
        #以下selenium
    when "https://www.bernardellistores.com/it/golden-goose"
        golden_n_woman.bernardelli_crawl_selenium(attack_site_url, @price)
        #小数点調整なし
    when "https://www.dante5.com/it-IT/donna/designer/golden_goose_deluxe_brand"
        golden_n_woman.dante5_crawl_selenium(attack_site_url, @price, @category)
        @price = @price.delete(".")
    when "https://www.genteroma.com/it/designer/donna/golden-goose.html"
        golden_n_woman.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.spinnakerboutique.com/it-IT/donna/designer/golden_goose"
        golden_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://viettishop.com/it/collections/golden-goose/women"
        golden_n_woman.vietti_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    end
end

# スウェーデン
# https://www.nathalieschuterman.com/en/marni

# https://www.lenoirboutique.com/manufacturer/max-mara.html
# https://www.agnettiboutique.it/eu/brands-woman

# https://www.antonia.it/it/brands?category=4

# https://www.frmoda.com/en/designer/golden-goose
# https://www.flanella.com/collections/woman

# https://www.ceneregb.com/en/woman/designers
# https://www.chirullishop.com/it/brands

# https://www.divincenzoboutique.com/en/women/designers
# https://www.dante5.com/it-IT/donna/designers

# https://shop.jofre.eu/pages/brands

# https://www.matchesfashion.com/intl/womens/designers

# https://www.parisricci.com/it/brands-woman

# https://www.slamjam.com/en_IT/woman/brands

# https://www.thedoublef.com/it_en/man/designers

# UK
# https://www.zeeandco.co.uk/womens/brands
# https://www.viettishop.com/it/designers/golden-goose?cat=456

# https://www.viettishop.com/it/designers/golden-goose?cat=456

# https://www.alducadaosta.com/it/donna/designer/golden_goose/borse
# https://suitnegozi.com/collections/golden-goose-deluxe-brand-donna?page=2
# https://www.capsulebyeso.com/en/men-golden+goose+deluxe+brand?page=2

# https://www.biffi.com/jp_en/women/designers/golden-goose?___store=jp_en

#https://ilsellaio.it/collections/golden-goose
#https://www.cettire.com/jp/products/golden-goose-deluxe-brand-low-top-sneakers-921507123/cmVhY3Rpb24vcHJvZHVjdDpBaGdXRG45WEhTYU5BdDJjeQ%3D%3D
#https://www.spaziopritelli.com/eu/woman/designers/golden-goose.html?page=2
