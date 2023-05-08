require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#angelo Eleonora修正済み
class VipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = ""
    @currency = 
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end 
    def self.call_price
        @price
    end
    def self.call_currency
        @currency
    end
ATTACK_LIST_URL = [

    nokogiri系
    https://actuelb.com/en/
    https://www.farfetch.com/it/shopping/women/AMR/items.aspx
    https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx
    https://www.coltortiboutique.com/it/designers
    https://eleonorabonucci.com/en/women/designers
    https://www.gaudenziboutique.com/en-it/women/designers
    https://www.leam.com/it_eu/designer.html
    https://www.michelefranzesemoda.com/it/donna/designers
    https://nugnes1920.com/pages/woman-designer
    https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi
    https://www.sigrun-woehr.com/en/BRANDS/
    https://suitnegozi.com/pages/designer-donna?redirect=true&shippingCountry=IT
    
    
    selenium系サイトのブランド一覧
    https://www.alducadaosta.com/it/donna/designers
    https://www.minettiangeloonline.com/it/register.html
    https://www.brunarosso.com/designers
    https://www.blondieshop.com/it/donna/woman-designer.html
    https://www.gebnegozionline.com/it_it/donna/designers
    https://www.montiboutique.com/it-IT/donna/designers
    http://specialshop.atelier98.net/it/register.html
    https://www.wiseboutique.com/it_it/donna/designers

]

    vip__woman = VipWoman.new
    @price = VipWoman.call_price
    @category = VipWoman.call_category
    @currency = VipWoman.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when 
            vip__woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            vip__woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when 
            vip__woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when 
            vip__woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when 
            vip__woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when 
            vip__woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when 
            vip__woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when 
            vip__woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            vip__woman.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when 
            vip__woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            vip__woman.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when 
            vip__woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            vip__woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列
        when 
            vip__woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "" 
            vip__woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            #vip__woman.brunarosso_crawl_selenium(attack_site_url, @price, @category, "")
            @price = @price.delete(",") #新サイト移行に伴い調整
        when 
            vip__woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            vip__woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when 
            vip__woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when ""
            vip__woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when 
            vip__woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end

nokogiri系
https://actuelb.com/en/
https://www.farfetch.com/it/shopping/women/AMR/items.aspx
https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx
https://www.coltortiboutique.com/it/women-designer
https://eleonorabonucci.com/en/woman/designers
https://www.gaudenziboutique.com/en-it/women/designers
https://www.leam.com/it_eu/designer.html
https://www.michelefranzesemoda.com/it/donna/designers
https://nugnes1920.com/pages/woman-designer
https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi
https://www.sigrun-woehr.com/en/BRANDS/
https://suitnegozi.com/pages/designer-donna?redirect=true&shippingCountry=IT


selenium系サイトのブランド一覧
https://www.alducadaosta.com/it/donna/designers
https://www.minettiangeloonline.com/it/register.html
https://www.brunarosso.com/s/designers/?gender=woman
https://www.blondieshop.com/it/donna/woman-designer.html
https://www.gebnegozionline.com/it_it/donna/designers
https://www.montiboutique.com/it-IT/donna/designers
http://specialshop.atelier98.net/it/register.html
https://www.wiseboutique.com/it_it/donna/designers


画像が使える買付け先リスト
https://actuelb.com/en/
https://amrstore.com/collections
https://www.coltortiboutique.com/it/men-designer
https://eleonorabonucci.com/en/men/designers
https://www.gaudenziboutique.com/en-it/men/designers
https://www.leam.com/it_eu/designer.html
https://www.michelefranzesemoda.com/it/uomo/designers
https://nugnes1920.com/pages/man-designer
https://www.sigrun-woehr.com/en/Brands/
https://www.russocapri.com/it/uomo/categorie/shopping/gruppi/nuovi-arrivi

selenium系
https://www.brunarosso.com/s/designers/?gender=men
https://www.blondieshop.com/it/man/man-designer.html
https://www.gebnegozionline.com/it_it/uomo/designers
https://www.montiboutique.com/it-IT/uomo/designers
https://www.wiseboutique.com/it_it/uomo/designers


微妙なサイト トップ画像だけ使う?
https://www.alducadaosta.com/it/uomo/designers
https://www.minettiangeloonline.com/it/register.html
https://www.tessabit.com/it_it/uomo/designers.html?page=1

