#require './ファイル名'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class MarniVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby marni_woman_v.rb
    @category = "靴"
    @price = "590"
    include AuzmendiFarfetchWoman, ColtortiWoman, EleonorabonucciFarfetchWoman, Gaudenzi, GbFarfetchWoman, Nugnes, Russocapri, SigrunWoehr
    include Alducadaosta, AngeloMinetti,  BrunarossoWoman, Eleonorabonucci, Gb, Monti, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end
ATTACK_LIST_URL = [
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?page=1&view=90&sort=3&scale=274&designer=4224",
    "https://www.coltortiboutique.com/it/designer/marni?cat=166",
    "https://eleonorabonucci.com/en/marni/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/marni",
    "マイケル",
    "https://nugnes1920.com/collections/marni-woman",
    "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=marni",
    #"https://www.sigrun-woehr.com/en/By-Brand/Marni/", なくなった
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/marni",
    "https://www.minettiangeloonline.com/it/woman?idt=176",
    "https://www.brunarosso.com/designer/483-marni-woman",
    "https://www.gebnegozionline.com/it_it/donna/designers/marni.html",
    "https://www.wiseboutique.com/it_it/donna/designers/marni.html",
    #tessabit b2bサイトには無い
    "https://www.montiboutique.com/it-IT/donna/designer/marni"
    ]

    vip_marni_woman = MarniVipWoman.new
    @price = MarniVipWoman.call_price
    @category = MarniVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&sort=2&scale=274&designer=4224"
            vip_marni_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/marni?cat=166"
            vip_marni_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&sort=2&scale=274&designer=4224"
            vip_marni_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/marni/women"
            vip_marni_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/women/designer/marni"
            vip_marni_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&rootCategory=Women&designer=4224"
            vip_marni_woman.gbfarfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/marni-woman"
            vip_marni_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=marni"
            vip_marni_woman.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Marni/"
            vip_marni_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #以下selenium
        when "https://www.alducadaosta.com/it/donna/designer/marni"
            vip_marni_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=176" 
            vip_marni_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/483-marni-woman"
            vip_marni_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category, "MARNI")
            #商品価格はそのまま
        # when "https://eleonorabonucci.com/en/marni/women/sale"
        #     vip_marni_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        #     @price = @price.delete(".")    
        when "https://www.gebnegozionline.com/it_it/donna/designers/marni.html"
            vip_marni_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/marni"
            vip_marni_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/marni.html"
            vip_marni_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")        
        end
    end


#出品順序
#Angelo Minetti 
#coltortiboutique
#brunarosso
#alducadaosta
