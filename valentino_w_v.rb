require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class ValentinoVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby valentino_w_v.rb
    @category = "靴"
    @price = "950"
    @currency = 146.9
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
    #"https://amrstore.com/collections/valentino",
    #"https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=10533|534369",
    "https://www.coltortiboutique.com/it/designer/valentino?cat=166",
    "https://eleonorabonucci.com/en/valentino/women", #サングラスだけ?
    "https://www.gaudenziboutique.com/en-it/women/designer/valentino_garavani", #服も統一
    "https://www.leam.com/it_eu/designer/valentino-garavani-donna.html", #服も統一
    "https://nugnes1920.com/collections/valentino-woman",
    #"https://www.sigrun-woehr.com/en/By-Brand/Valentino/",
    "https://suitnegozi.com/collections/valentino-donna",
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/valentino",
    "https://www.minettiangeloonline.com/it/woman?idt=99",
    #"https://www.brunarosso.com/designer/605-valentino-woman",
    "https://www.gebnegozionline.com/it_it/donna/designers/valentino.html",
    "https://www.wiseboutique.com/it_it/donna/designers/valentino.html",
    "http://specialshop.atelier98.net/it/donna?idt=1980000152",
    "https://www.blondieshop.com/it/donna/woman-designer/valentino.html",
    "https://www.montiboutique.com/it-IT/donna/designer/valentino"
    
]

    valentino_vip_woman = ValentinoVipWoman.new
    @price = ValentinoVipWoman.call_price
    @category = ValentinoVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/valentino"
            valentino_vip_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=10533|534369"
            valentino_vip_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/valentino?cat=166"
            valentino_vip_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/valentino"
            valentino_vip_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/valentino-donna.html"
            valentino_vip_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/valentino-woman"
            valentino_vip_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Valentino/"
            valentino_vip_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/valentino-donna"
            valentino_vip_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はselenium系列  
        when "https://www.alducadaosta.com/it/donna/designer/valentino"
            valentino_vip_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=99" 
            valentino_vip_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/designer/605-valentino-woman"
            valentino_vip_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category, "VALENTINO")
            @price = @price.delete(",") #新サイト以降に伴い調整済み
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/valentino.html"
            valentino_vip_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/valentino.html"
            valentino_vip_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/valentino"
            valentino_vip_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000152"
            valentino_vip_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.wiseboutique.com/it_it/donna/designers/valentino.html"
            valentino_vip_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end




# https://www.coltortiboutique.com/it/designer/valentino?cat=166
# https://suitnegozi.com/collections/valentino-donna
# https://www.alducadaosta.com/it/donna/designer/valentino
# https://www.wiseboutique.com/it_it/donna/designers/valentino.html

# https://vip.brunarosso.com/s/designers/valentino/

# https://www.blondieshop.com/it/donna/woman-designer/valentino.htm
# https://www.tessabit.com/it_it/donna/designers/valentino.html

# https://amrstore.com/collections/valentino
# https://nugnes1920.com/collections/valentino-woman
# https://www.sigrun-woehr.com/en/By-Brand/Valentino/
# https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=10533|534369

# https://www.gebnegozionline.com/it_it/donna/designers/valentino.html
# https://www.gaudenziboutique.com/en-it/women/designer/valentino
# https://www.leam.com/it_eu/designer/valentino-donna.html
# https://www.montiboutique.com/it-IT/donna/designer/valentino




