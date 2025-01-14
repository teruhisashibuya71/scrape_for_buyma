require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#corso改修済み
#vietti回収済み
class MarniNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby marni_man_n.rb
    @category = "服"
    @price = "850"
    @currency = 150.1
    #include + クラス名
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
    #"https://www.julian-fashion.com/it-IT/uomo/designer/marni",
    #https://www.family3-0.com/gb/263_marni
    #"https://www.dipierrobrandstore.it/en/39_marni/s-17/brand-marni/gender-man"
    #"https://www.lidiashopping.com/it/JP/men/t/designers/marni?country=IT"
    
    #以下selenium
    #"https://www.bernardellistores.com/it/uomo/marni?order=LATEST",
    #"https://10corsocomo.com/en-jp/collections/marni?filter.p.m.elastick.gender=Man",
    "https://viettishop.com/it/collections/marni/men"
]

marni_n_man = MarniNormalMan.new
@price = MarniNormalMan.call_price
@category = MarniNormalMan.call_category
@currency = MarniNormalMan.call_currency

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.julian-fashion.com/it-IT/uomo/designer/marni"
        marni_n_man.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://viettishop.com/it/collections/marni/men"
        marni_n_man.vietti_crawl(attack_site_url, @price)
        @price = @price.delete(".") # 再改修後に調整済み
    
    #以下selenium
    when "https://www.bernardellistores.com/it/uomo/marni?order=LATEST"
        marni_n_man.bernardelli_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://10corsocomo.com/en-jp/collections/marni?filter.p.m.elastick.gender=Man"
        marnπi_n_man.corsocomo_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    end
end

#https://www.portaliboutique.it/en/shipping.html
#日本発送ありでも発送できないと表示でるにで交渉する必要あり
# https://www.dr-adams.dk/maerke/marni#p=0
# https://www.jp.forzieri.com/jpn/brand_collection.asp?l=jpn&c=jpn&brand_id=362&gr=2
# https://www.thedoublef.com/ea_en/man/designers/marni/
# https://www.ilduomo.it/designer/marni.html?gender=man&resultsPerPage=2000&order=product.date_add.desc
# https://www.bernardellistores.com/it/uomo/marni?order=LATEST
# https://www.viettishop.com/it/designers/marni?cat=462
# ttps://www.romeoboutique.com/marni
# https://www.d2-store.com/it/tutti/designer/marni/gruppi
# https://www.julian-fashion.com/it-IT/uomo/designer/marni

#https://www.societeanonyme.it/en/15-clothing?q=Brand-MARNI
#スウェーデン
#https://www.paul-friends.com/product/marni-unfinished-edge-cotton-sweatshirt/

#https://it.slamjam.com/collections/marni

# https://www.jp.doshaburi.com/collections/marni
#https://www.10corsocomo-theshoponline.com/ita_en/brand/marni-man
#https://www.dipierrobrandstore.it/en/39_marni/s-6/categories-man/brand-marni/gender-man/categories_level_1-man


#https://www.romeoboutique.com/marni
#https://www.danielloboutique.it/uk/man/designer/marni.html
#https://www.sevenstore.com/brands/marni/


#https://palazzobelli.it/sweatshirts/15794-36351-white-pink-and-blue-cotton-sweatshirtkpmk.html#/2160-size-40
#https://www.societeanonyme.it/en/15-clothing?q=Brand-MARNI
#https://stylemyle.com/shop/products/marni-9082267f-c8c1-4dd4-a8dd-c9b2102bc345?awc=22486_1675589957_a4bd179ac16e807eae0673b919968202#modesens=1

