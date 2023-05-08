require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class MiumiuVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby miumiu_v.rb
    @category = "アクセ"
    @price = "420"
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
ATTACK_LIST_URL = [    
    "https://amrstore.com/collections/miu-miu",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=8360",
    "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=8360",
    "https://www.coltortiboutique.com/it/designer/miu_miu?cat=166",
    #"https://www.sigrun-woehr.com/en/By-Brand/Miu-Miu/",
    "https://suitnegozi.com/collections/miu-miu-donna",

    #以下selenium
    "https://www.minettiangeloonline.com/it/woman?idt=385",
    "https://www.gebnegozionline.com/it_it/donna/designers/miu-miu.html",
    "https://www.brunarosso.com/s/designers/miu-miu/?category=women",
    "https://www.tessabit.com/it_it/donna/designers/miu-miu.html",
    "https://www.blondieshop.com/it/donna/woman-designer/miu-miu.html",
    "https://www.montiboutique.com/it-IT/donna/designer/miu_miu"
]
    vip_miumiu_woman = MiumiuVipWoman.new
    @price = MiumiuVipWoman.call_price
    @category = MiumiuVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/miu-miu"
            vip_miumiu_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=8360"
            vip_miumiu_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&rootCategory=Women&designer=8360"
            vip_miumiu_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/miu_miu?cat=166"
            vip_miumiu_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Miu-Miu/"
            vip_miumiu_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/miu-miu-donna"
            vip_miumiu_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下はseleniu系列
        when "https://www.brunarosso.com/s/designers/miu-miu/?category=women"
            vip_miumiu_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/miu-miu.html"
            vip_miumiu_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/miu-miu.html"
            vip_miumiu_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/miu_miu"
            vip_miumiu_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/miu-miu.html"
            vip_miumiu_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end