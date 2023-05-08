require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class PradaVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby prada_woman_v.rb
    @category = "靴"
    @price = "620"
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    "https://amrstore.com/collections/prada",
    "https://amrstore.com/collections/prada-handbags",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=34624",
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=34624",
    # 商品なくなった? "https://www.coltortiboutique.com/it/designer/prada?cat=166",
    "https://nugnes1920.com/collections/prada-woman",
    #"https://www.sigrun-woehr.com/en/By-Brand/Prada/",
    "https://suitnegozi.com/collections/prada-donna",
    
    #selenium
    "https://www.gebnegozionline.com/it_it/donna/designers/prada.html",
    "http://specialshop.atelier98.net/it/donna?idt=1980000893",
    "https://www.blondieshop.com/it/donna/woman-designer/prada.html",
    "https://www.montiboutique.com/it-IT/donna/designer/prada"
] 

    vip_prada_woman = PradaVipWoman.new
    @price = PradaVipWoman.call_price
    @category = PradaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/prada"
            vip_prada_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=34624"
            vip_prada_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://amrstore.com/collections/prada-handbags"
            if (@category == "バッグ")
                vip_prada_woman.amr_crawl(attack_site_url, @price)
                @price = @price.delete(",")
            end
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=34624"
            vip_prada_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/prada?cat=166"
            vip_prada_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/prada-woman"
            vip_prada_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/SHOES/All-Shoes/41-oxid-2020.html"
            vip_prada_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/prada-donna"
            vip_prada_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        #selenium
        when "https://www.blondieshop.com/it/donna/woman-designer/prada.html"
            vip_prada_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/prada.html"
            vip_prada_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000893"
            vip_prada_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when "https://www.montiboutique.com/it-IT/donna/designer/prada"
            vip_prada_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        end
    end
