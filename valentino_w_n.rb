require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#corsocomoまで改修済み 4/23
class ValentinoNormalWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby valentino_w_n.rb
    @category = "服"
    @price = "390"
    @is_garavani = false
    @currency = 149.5
    include Aldogibilaro, Capsel, Cortecci, Ekseption, Grifo, Ilduomo, Julian, Lidia, LuisaWorld, Mycompanero, Smets
    include Bernardelli, Corsocomo, Credoman, Dante5, Genteroma, Labels, Ottodisapietro, Papini, Plline, Spinnaker, Vietti
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
    def self.call_is_garavani
        @is_garavani
    end
    def self.call_currency
        @currency
    end
end

ATTACK_LIST_URL = [
    #nokogiri系
    #"https://www.capsulebyeso.com/en/women-valentino+garavani", #valentino取り扱いなし
    ##"https://grifo210.com/iit/catalog/category/view/s/valentinogaravani/id/492/?sale=0", #valentinoGaravaniのみだが、服も一緒に表示
    #"https://www.ilduomo.it/designer/valentino-garavani.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc", #vag
    #"https://www.ilduomo.it/designer/valentino.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc", #valentino
    #"https://www.julian-fashion.com/en-IT/women/designer/valentino_garavani", #valentinoGaravaniだけだが、服も一緒に表示
    #"https://www.luisaworld.com/woman/designers/valentino-garavani/",  #valentinoGaravaniだけだが、服も一緒に表示
    #"https://www.mycompanero.com/fr/brand/10-valentino?categories=femme", #VALENTINOだけ。だが服の取り扱いはなく、小物類だけの取り扱い
    #"https://smets.lu/collections/valentino/women", #valentinoだけ。valentinoで両方とのアイテムを表示。
#
    ##selenium
    #"https://www.genteroma.com/it/designer/donna/valentino-garavani.html", #服も一緒
    #"https://ottodisanpietro.com/collections/valentino-women", #服も一緒
    "https://www.papinistore.com/donna-brand-valentino",  #商品無し
    "https://www.papinistore.com/donna-brand-valentino-garavani",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/valentino",
    "https://www.spinnakerboutique.com/it-IT/donna/designer/valentino_garavani",
    "https://viettishop.com/it/collections/valentino/women",
    "https://viettishop.com/it/collections/valentino-garavani/women"
]

    valentino_n_woman = ValentinoNormalWoman.new
    @price = ValentinoNormalWoman.call_price
    @category = ValentinoNormalWoman.call_category
    @is_garavani = ValentinoNormalWoman.call_is_garavani
    @currency = ValentinoNormalWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.capsulebyeso.com/en/women-valentino+garavani"
            if (@is_garavani)
                valentino_n_woman.capsel_crawl(attack_site_url, @price)
                @price = @price.delete(".")  
            end
        when "https://grifo210.com/iit/catalog/category/view/s/valentinogaravani/id/492/?sale=0"
            valentino_n_woman.grifo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.ilduomo.it/designer/valentino.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc" 
            valentino_n_woman.ilduomo_crawl(attack_site_url, @price, @currency)
            #日本円調整のため小数点調整は無し
            if (@is_garavani)
                valentino_n_woman.ilduomo_crawl("https://www.ilduomo.it/designer/valentino-garavani.html?gender=woman&resultsPerPage=2000&order=product.date_add.desc", @price, @currnecy)
            end
        when "https://www.julian-fashion.com/en-IT/women/designer/valentino_garavani"
            valentino_n_woman.julian_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.luisaworld.com/woman/designers/valentino-garavani/"
            valentino_n_woman.luisa_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.mycompanero.com/fr/brand/10-valentino?categories=femme"
            if (@is_garavani)
                valentino_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(",")
            end
        when "https://smets.lu/collections/valentino/women"
            valentino_n_woman.smets_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.genteroma.com/it/designer/donna/valentino-garavani.html"
            valentino_n_woman.gente_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://ottodisanpietro.com/collections/valentino-women"
            valentino_n_woman.ottodisapietro_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.papinistore.com/donna-brand-valentino"
            #valentino_n_woman.papini_crawl_selenium(attack_site_url, @price, @currency)
            #小数点削除必要無し
            if (@is_garavani)
                valentino_n_woman.papini_crawl_selenium("https://www.papinistore.com/donna-brand-valentino-garavani", @price, @currency)
            end
        when "https://www.spinnakerboutique.com/it-IT/donna/designer/valentino"
            valentino_n_woman.spinnnaker_crawl_selenium(attack_site_url, @price)
            #小数点削除必要無し
            if (@is_garavani)
                valentino_n_woman.spinnnaker_crawl_selenium("https://www.spinnakerboutique.com/it-IT/donna/designer/valentino_garavani", @price)
            end
        when "https://viettishop.com/it/collections/valentino/women"
            valentino_n_woman.vietti_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
            if (@is_garavani)
                valentino_n_woman.vietti_crawl_selenium("https://viettishop.com/it/collections/valentino-garavani/women", attack_site_url, @price)
                @price = @price.delete(".")
            end
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
