#require './ファイル名'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

#ひとまず完成
class BottegaVipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby bottega_w_v.rb
    @category = "バッグ"
    @price = "1800"
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
    "https://amrstore.com/collections/bottega-veneta",
    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=19047",
    "https://www.coltortiboutique.com/it/designer/bottega_veneta?cat=166",
    "https://eleonorabonucci.com/en/bottega-veneta/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/bottega_veneta",
    "https://www.leam.com/en/designer/bottega-veneta-women.html",
    "https://nugnes1920.com/collections/bottega-veneta-woman",
    #"https://www.sigrun-woehr.com/en/By-Brand/Bottega-Veneta/",
    "https://suitnegozi.com/collections/bottega-veneta-donna",

    ##selenium
    "https://www.alducadaosta.com/it/donna/designer/bottega_veneta",
    "https://www.gebnegozionline.com/it_it/donna/designers/bottega-veneta.html",
    "https://www.brunarosso.com/s/designers/bottega-veneta/?category=women",
    "https://www.blondieshop.com/it/donna/woman-designer/bottega-veneta.html",
    "http://specialshop.atelier98.net/it/donna?idt=1980000002",
    "https://www.tessabit.com/it_it/donna/designers/bottega-veneta.html?page=1",
    "https://www.montiboutique.com/it-IT/donna/designer/bottega_veneta"
    ]

    vip_bottega_woman = BottegaVipWoman.new
    @price = BottegaVipWoman.call_price
    @category = BottegaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/bottega-veneta"
            vip_bottega_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=19047"
            vip_bottega_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/bottega_veneta?cat=166"
            vip_bottega_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/bottega-veneta/women"
            vip_bottega_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.gaudenziboutique.com/en-it/women/designer/bottega_veneta"
            vip_bottega_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en/designer/bottega-veneta-women.html"
            vip_bottega_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/bottega-veneta-woman"
            vip_bottega_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Bottega-Veneta/"
            vip_bottega_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/bottega-veneta-donna"
            vip_bottega_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下はselenium系列
        when "https://www.alducadaosta.com/it/donna/designer/bottega_veneta"
            vip_bottega_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/bottega-veneta/?category=women"
            vip_bottega_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category, "BOTTEGA_VENETA")
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/bottega-veneta.html"
            vip_bottega_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/bottega-veneta.html"
            vip_bottega_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/bottega_veneta"
            vip_bottega_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna?idt=1980000002"
            vip_bottega_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドット
        #when "https://www.tessabit.com/it_it/donna/designers/bottega-veneta.html?page=1"
        #    vip_bottega_woman.tessabit_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(",")
        end
    end


#https://www.net-a-porter.com/en-gb/shop/product/bottega-veneta/bags/cross-body/loop-mini-intrecciato-leather-shoulder-bag/17411127377168899
#https://www.mytheresa.com/en-fr/bottega-veneta-loop-leather-crossbody-bag-1945153.html
#https://www.bottegaveneta.com/en-fr/search?q=loop+bag+mini
#https://www.bottegaveneta.com/en-fr/loop-black-666683VCPP38425.html
#https://www.google.com/search?q=BOTTEGA+VENETA+666683V&tbm=isch&ved=2ahUKEwjes42VqeP0AhVGXpQKHVKcCukQ2-cCegQIABAA&oq=BOTTEGA+VENETA+666683V&gs_lcp=CgNpbWcQAzIHCCMQ7wMQJzIHCCMQ7wMQJ1A5WDlgswFoAHAAeACAAVOIAZsBkgEBMpgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=DpK4Yd70FMa80QTSuKrIDg&bih=1015&biw=1866&rlz=1C5CHFA_enJP950JP950
#https://www.luxuryfashionstores.sk/en/88090/bottega-veneta-666683-vcpp3-loop-bag_p
#https://www.brownsfashion.com/jp/shopping/bottega-veneta-black-intrecciato-leather-small-cross-body-bag-16801044
#https://www.antonioli.eu/en/FK/women/products/666683vcpp3-8425
#https://www.thedoublef.com/ca_en/black-shoulder-bag-bottega-veneta-666683vcpp3-j-bv-8425/
#https://www.oluxury.com/uk/bottega-veneta-mini-bags-woman-666683vcpp38425-a21.html
#https://www.tizianafausti.com/eu_en/woman-bottega-veneta-woman-loop-small-shoulder-bag-in-intrecciato-nappa-666683vcpp38425-46001350-uni.html
#https://www.blondieshop.com/jp/cross-body-loop-bag-9335887-1862706869.html?___store=jp&___from_store=us
    