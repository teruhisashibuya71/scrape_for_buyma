require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'


#https://www.susi.it/s/susi/en_GB/search/f/jil-sander/
#https://www.fouramsterdam.com/brands/jil-sander/
class JilsanderNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby jilsander_man_n.rb
    @category = "アクセ"
    @price = "750"
    @currency = 139.7
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Julian, Lidia, LuisaWorld, Mycompanero, Smets, Vietti
    include Bernardelli, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, JilSanderFarfetchMan
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
    #"https://www.ekseption.com/ot_en/men/jil_sander.html",
    #"https://www.julian-fashion.com/en-IT/men/designer/jil_sander",
    
    #以下selenium
    #"https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/jil-sander-man",
    #"https://www.papinistore.com/uomo-brand-jil-sander",
    #"https://www.viettishop.com/it/uomo/designers/jil-sander"
    
    #farfetch
    "https://www.farfetch.com/it/shopping/men/jil-sander/items.aspx"
]

jil_n_man = JilsanderNormalMan.new
@price = JilsanderNormalMan.call_price
@category = JilsanderNormalMan.call_category
@currency = JilsanderNormalMan.call_currency

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url 
    when "https://www.ekseption.com/ot_en/men/jil_sander.html"
        jil_n_man.ekseption_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.julian-fashion.com/en-IT/men/designer/jil_sander"
        jil_n_man.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    
    #以下selenium
    #when "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/jil-sander-man"
    #    jil_n_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
    #    @price = @price.delete(",")
    when "https://www.papinistore.com/uomo-brand-jil-sander"
        jil_n_man.papini_crawl_selenium(attack_site_url, @price, @currency)
        #小数点削除必要無し
    when "https://www.viettishop.com/it/designers/jil-sander?cat=462"
        jil_n_man.vietti_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")

    #farfetch
    when "https://www.farfetch.com/it/shopping/men/jil-sander/items.aspx"
        jil_n_man.farfetch_crawl(attack_site_url, @price, @category)
        @price = @price.delete(".")
    end
end