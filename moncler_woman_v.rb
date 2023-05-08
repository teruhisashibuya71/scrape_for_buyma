require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class MonclerVipWoman
    #服 靴 バッグ アクセ
    #ruby moncler_woman_v.rb
    @category = "服"
    @price = "890"

    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Gaudenzi, Leam, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, Blondie, BrunarossoWoman, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
    ATTACK_LIST_URL = [
        "https://actuelb.com/en/88-women-s-moncler",
        "https://amrstore.com/collections/moncler",
        "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=4535",
        "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=4535",
        "https://www.coltortiboutique.com/it/designer/moncler?cat=166",
        "https://www.gaudenziboutique.com/en-it/women/designer/moncler",
        "https://www.leam.com/it_eu/designer/moncler-donna.html",
        "https://nugnes1920.com/collections/moncler-woman",
        "https://www.russocapri.com/it/donna/designer/moncler/gruppi",
        "https://suitnegozi.com/collections/moncler-donna",
        #"https://www.sigrun-woehr.com/en/By-Brand/Moncler/",
        #以下selenium
        "https://www.alducadaosta.com/it/donna/designer/moncler",
        "https://www.brunarosso.com/s/designers/moncler/?category=women",
        "https://www.gebnegozionline.com/it_it/donna/designers/moncler.html",
        "https://www.wiseboutique.com/en_it/donna/designers/moncler.html",
        "https://www.blondieshop.com/it/donna/woman-designer/moncler.html",
        "https://www.tessabit.com/en_it/woman/designers/moncler.html?page=1",
        "https://www.montiboutique.com/it-IT/Donna/designer/moncler"
    ]

    moncler_vip_woman = MonclerVipWoman.new
    @price = MonclerVipWoman.call_price
    @category = MonclerVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/88-women-s-moncler" 
            moncler_vip_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://amrstore.com/collections/moncler" 
            moncler_vip_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=4535" 
            moncler_vip_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=4535" 
            moncler_vip_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/moncler?cat=166" 
            moncler_vip_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/moncler" 
            moncler_vip_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/moncler-donna.html" 
            moncler_vip_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/moncler-woman" 
            moncler_vip_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/designer/moncler/gruppi"
            moncler_vip_woman.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/moncler-donna" 
            moncler_vip_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Moncler/" 
            moncler_vip_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
            #以下selenium
        when "https://www.alducadaosta.com/it/donna/designer/moncler" 
            moncler_vip_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/donna/woman-designer/moncler.html" 
            #puts "blondieスタート"
            moncler_vip_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/moncler/?category=women" 
            moncler_vip_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #商品価格はそのまま
        when "https://www.gebnegozionline.com/it_it/donna/designers/moncler.html" 
            moncler_vip_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/moncler" 
            moncler_vip_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/en_it/woman/designers/moncler.html?page=1" 
            moncler_vip_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")   
        when "https://www.wiseboutique.com/en_it/donna/designers/moncler.html" 
            moncler_vip_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end