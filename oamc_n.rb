require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/normal'

#ilduomoまで改修済み 1/15
class OamcNormalMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby oamc_n.rb
    @category = "服"
    @price = "790"
    @currency = 148.9
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
    #nokogiri系
    #"https://www.dope-factory.com/collections/oamc/M",
    #"https://grifo210.com/it/catalog/category/view/s/oamc/id/565/",
    #"https://10corsocomo.com/collections/oamc",
    
    #selenium
    #"https://www.genteroma.com/it/designer/uomo/oamc.html",
    #"https://labelsfashion.com/collections/men-oamc"
    "https://www.wrongweather.net/it/shop/brand/oamc"
]

    oamc_n_man = OamcNormalMan.new
    @price = OamcNormalMan.call_price
    @category = OamcNormalMan.call_category
    @ccurrency = OamcNormalMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
            when "https://grifo210.com/it/catalog/category/view/s/oamc/id/565/"
                oamc_n_man.grifo_crawl_selenium(attack_site_url, @price)
                @price = @price.delete(".")
            
                #以下selenium
            when "https://www.genteroma.com/it/designer/uomo/oamc.html"
                oamc_n_man.gente_crawl_selenium(attack_site_url, @price)
                @price = @price.delete(".")
            when "https://labelsfashion.com/collections/men-oamc"
                oamc_n_man.labels_crawl_selenium(attack_site_url, @price)
                #小数点削除必要無し
            when "https://www.wrongweather.net/it/shop/brand/oamc"
                oamc_n_man.wrong_crawl_selenium(attack_site_url, @price)
                @price = @price.delete(".")

            #farfetch
            # when ""
            #     oamc_n_man.farfetch_crawl(attack_site_url, @price, @category)
            #     @price = @price.delete(".")
        end
    end

#https://boutique-roma.ch/label/oamc/#grid
# https://www.shoppingmap.it/brand/6357-oamc?page=5#boutiques
# https://www.coggles.com/c/man/brand/oamc/
# https://alaralagos.com/
# http://www.alltoohumanboston.com/designers
# https://www.farfetch.com/it/shopping/men/all-too-human/items.aspx?designer=1684264
# https://andreasmurkudis.com/
# https://www.anticboutik.com/?s=OAMC
# https://www.google.com/search?q=DARIAL+OAMC&rlz=1C5CHFA_enJP950JP950&oq=DARIAL+OAMC&aqs=chrome..69i57.1416j0j7&sourceid=chrome&ie=UTF-8
# https://www.ikrix.com/it/brands/uomo
# https://www.theflamel.com/it/it/brands/uomo/oamc/
# https://stileo.it/oamc
# https://www.fashiola.it/uomo/abbigliamento/top-e-t-shirt/t-shirt/tshirt-a-maniche-lunghe/?mrk=oamc
# https://www.drezzy.it/offerte-moda?marca=oamc
# https://www.luisaviaroma.com/en-it/shop/men/oamc?lvrid=_gm_dgev&__s=MzA1NDkwOA
# https://deliberti.it/oamc-m-1543.html?uomodonna=1
# https://www.mariodannashop.it/it/uomo/designer/oamc
# https://us.wananluxury.com/en-jp/collections/vendors?q=Oamc
# https://www.ln-cc.com/ja/%E3%83%96%E3%83%A9%E3%83%B3%E3%83%89/%E3%83%A1%E3%83%B3%E3%82%BA/oamc/
# https://www.modes.com/it/shopping/man/oamc
# https://hbx.com/men/brands/oamc?page=2
# https://hbx.com/men/brands/oamc/cosmos-kurt-shirt-pastel-grey
# https://jp.slamjam.com/collections/oamc
# https://www.google.com/search?q=OAMC+%E3%83%96%E3%83%A9%E3%83%B3%E3%83%89&newwindow=1&rlz=1C5CHFA_enJP950JP950&sxsrf=APwXEdePAuGNPLAMc67VOhlX6MRozx63ZA%3A1682011568551&ei=sHVBZL6dIc7d2roPlOewkAI&ved=0ahUKEwi-tbSw_bj-AhXOrlYBHZQzDCIQ4dUDCA8&uact=5&oq=OAMC+%E3%83%96%E3%83%A9%E3%83%B3%E3%83%89&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIHCAAQBBCABDoICAAQogQQsAM6CAghEKABEMMESgQIQRgBUIsFWLIXYNIYaABwAHgAgAGpAYgBsQOSAQMwLjOYAQCgAQHIAQTAAQE&sclient=gws-wiz-serp
# https://www.yoox.com/jp/%E3%83%A1%E3%83%B3%E3%82%BA/shoponline/oamc_d#/dept=men&d=26436
# https://jp.oamc.com/ja/collections/shirts/products/kepler-shirt-rose-23e28oau60tcot00825-660
# https://jp.oamc.com/ja/collections/shirts/products/kepler-shirt-rose-23e28oau60tcot00825-660
# https://www.google.com/search?q=OAMC+ROSE+shirt&tbm=isch&ved=2ahUKEwi-wq70_rj-AhVKdXAKHVgfAGIQ2-cCegQIABAA&oq=OAMC+ROSE+shirt&gs_lcp=CgNpbWcQAzoECCMQJzoECAAQHjoGCAAQCBAeOgcIABAYEIAEOgUIABCABFAAWNAdYLgeaAJwAHgDgAGfAogBkw-SAQYxMS40LjKYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=S3dBZP7wHcrqwQPYvoCQBg
# https://sv77.com/men/oamc-designer/
# https://www.hlorenzo.com/collections/oamc
# https://www.google.com/search?q=OAMC+Kepler+shirts+pink&newwindow=1&rlz=1C5CHFA_enJP950JP950&sxsrf=APwXEdew_RjMQ0f2XHCS1AjlhAE05YgQvQ:1682012043925&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiD-4qT_7j-AhUIQt4KHdfcCtMQ_AUoAnoECAEQBA&biw=1619&bih=914&dpr=2
# https://jp.slamjam.com/collections/oamc

# https://www.thebusinessfashion.com/collections/oamc
# https://www.galianostore.com/it_it/uomo/oamc.html
# https://www.giglio.com/oamc/uomo.html
# https://www.glamood.com/it/oamc-B1474.htm
# https://www.walmart.com/search?q=oamc
# https://www.shoppingmap.it/negozi/1286-minetti.html
# https://www.theflamel.com/it/it/brands/uomo/oamc/