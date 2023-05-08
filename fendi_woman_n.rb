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


#spinakerの件はOK
class FendiNormalWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby fendi_woman_n.rb
    @category = "靴"
    @price = "895"
    
    #include + クラス名
    include Aldogibilaro
    include Capsel
    include Cortecci
    #include Ekseption
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
    #ブランド消えた"https://www.aldogibilaro.com/en/10000064_fendi",
    #ブランド消えた "https://www.ekseption.com/ot_en/designers/fendi?cat=3",
    "https://grifo210.com/en/catalog/category/view/s/fendi/id/354/?sale=0",
    "https://www.julian-fashion.com/en-IT/women/designer/fendi",
    "https://www.luisaworld.com/product-category/woman/?product_brand=fendi",
    "https://www.mycompanero.com/fr/brand/41-fendi?categories=femme",
    "https://smets.lu/collections/fendi/women",
    
    #以下selenium
    "https://www.spinnakerboutique.com/it-IT/donna/designer/fendi",
    "https://www.papinistore.com/en/24_fendi"
    

]

fendi_n_woman = FendiNormalWoman.new
@price = FendiNormalWoman.call_price
@category = FendiNormalWoman.call_category

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.aldogibilaro.com/en/10000064_fendi"
        fendi_n_woman.aldogibilaro_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    #when "https://www.ekseption.com/ot_en/designers/fendi?cat=3"
    #    fendi_n_woman.ekseption_crawl(attack_site_url, @price)
    #    @price = @price.delete(",")
    when "https://grifo210.com/en/catalog/category/view/s/fendi/id/354/?sale=0"
        fendi_n_woman.grifo_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.julian-fashion.com/en-IT/women/designer/fendi"
        fendi_n_woman.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.luisaworld.com/product-category/woman/?product_brand=fendi"
        fendi_n_woman.luisa_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.mycompanero.com/fr/brand/41-fendi?categories=femme"
        fendi_n_woman.mycompanero_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://smets.lu/collections/fendi/women"
        fendi_n_woman.smets_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    #以下selenium
    when "https://www.papinistore.com/en/24_fendi"
        fendi_n_woman.papini_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.spinnakerboutique.com/it-IT/donna/designer/fendi"
        fendi_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し 
    end
end


#https://www.emerson-renaldi.com/en/search?search=fendi&tab=product