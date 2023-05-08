require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'


class MaxmaraVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #ruby maxmara_v.rb
    @category = "バッグ"
    @price = "750"
    @currency = 141.7
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
end

ATTACK_LIST_URL = [
    "https://amrstore.com/collections/max-mara",
    "https://www.coltortiboutique.com/it/designer/max_mara?cat=166",    
    "https://eleonorabonucci.com/en/max-mara/women",
    "https://www.gaudenziboutique.com/en-it/women/designer/max_mara",
    "https://www.leam.com/en_en/designer/max-mara-women.html",
    "https://nugnes1920.com/collections/max-mara-woman",
    "https://www.russocapri.com/en/all/designer/max-mara/groups",
    "https://suitnegozi.com/collections/max-mara-donna",
    
    #selenium
    "https://www.alducadaosta.com/it/donna/designer/max_mara",
    "https://www.minettiangeloonline.com/it/woman?idt=438",
    "https://www.brunarosso.com/s/designers/max-mara/?category=women",
    "http://specialshop.atelier98.net/it/donna?idt=1980000791",
    "https://www.blondieshop.com/it/donna/woman-designer/max-mara.html",
    "https://www.montiboutique.com/it-IT/Donna/designer/max_mara"
    
    #S MAX MARA
    #"https://eleonorabonucci.com/en/s-max-mara/women"

    #Sports Max
    #"https://eleonorabonucci.com/en/sportmax/women?&f=eyJPcmRpbmFtZW50byI6MCwiQ2F0ZWdvcnkiOltdLCJCcmFuZCI6W10sIkNvbG9yIjpbXSwiU2l6ZSI6W10sIlRhZ2xpYSI6W10sIlNhbGRpIjp0cnVlLCJOdW92YUNvbGxlemlvbmUiOmZhbHNlLCJLaWRzTWVuIjp0cnVlLCJLaWRzV29tZW4iOnRydWUsIlNpemVLaWRzIjowLCJTZXF1ZW56YSI6W10sIkxibEZpbHRyb0tpZHNNb2JpbGUiOm51bGwsIkxibEZpbHRyb1NpemVLaWRzTW9iaWxlIjpudWxsfQ=="
    
    #Sports Max Code
    #"https://eleonorabonucci.com/en/sportmax-code/women"


    #MaxMaraStudio
    #"https://www.michelefranzesemoda.com/it/donna/designer/maxmara-studio/",
]

    vip_mara_woman = MaxmaraVipWoman.new
    @price = MaxmaraVipWoman.call_price
    @category = MaxmaraVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://amrstore.com/collections/max-mara"
            vip_mara_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/it/designer/max_mara?cat=166"
            vip_mara_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/max-mara/women"
            vip_mara_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when "https://www.gaudenziboutique.com/en-it/women/designer/max_mara"
            vip_mara_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/en_en/designer/max-mara-women.html"
            vip_mara_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/max-mara-woman"
            vip_mara_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/en/all/designer/max-mara/groups"
            vip_mara_woman.russo_crawl(attack_site_url, @price)
        when "https://suitnegozi.com/collections/max-mara-donna"
            vip_mara_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when "https://www.alducadaosta.com/it/donna/designer/max_mara"
            vip_mara_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/max-mara/?category=women"
            vip_mara_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #別の変数に代入して使用しているため調整不要
        when "https://www.blondieshop.com/it/donna/woman-designer/max-mara.html"
            vip_mara_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/max_mara"
            vip_mara_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/max-mara.html?page=1"
            vip_mara_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")

        #MamMaraStudio
        when "https://www.michelefranzesemoda.com/it/donna/designer/maxmara-studio/"
            vip_mara_woman.michele_crawl(attack_site_url, @price)
            #価格調整無し

        end
    end


    #https://amrstore.com/collections/max-mara/products/max-mara-madame2-coat-1
    #https://www.coltortiboutique.com/it/designer/max_mara_the_cube?cat=166
    #https://www.coltortiboutique.com/it/designer/max_mara_studio?cat=166
    #https://www.coltortiboutique.com/it/designer/max_mara?cat=166
    #https://www.coltortiboutique.com/it/designer/s_max_mara?cat=166
    #https://www.gaudenziboutique.com/en-it/women/designer/max_mara
    #https://www.gaudenziboutique.com/en-it/women/designer/maxmara_leisure
    #https://www.gaudenziboutique.com/en-it/women/designer/s_maxmara
    #https://www.leam.com/it_eu/designer/max-mara-donna.html
    #https://www.michelefranzesemoda.com/it/donna/designer/maxmara-studio/
    #https://nugnes1920.com/collections/s-max-mara-woman
    #https://nugnes1920.com/collections/max-mara-woman
    #https://nugnes1920.com/collections/maxmara-the-cube-woman
    #https://nugnes1920.com/collections/sportmax-woman
    #https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=max-mara
    #https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=s-max-mara
    #https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=sportmax
    #https://suitnegozi.com/collections/max-mara-donna
    #https://suitnegozi.com/collections/max-mara-the-cube-donna
    #


#    https://www.alducadaosta.com/it/donna/designer/s_max_mara
#https://www.alducadaosta.com/it/donna/designer/sportmax
#https://vip.brunarosso.com/s/designers/s-max-mara/
#https://vip.brunarosso.com/s/designers/max-mara-atelier/
#https://vip.brunarosso.com/s/designers/max-mara-studio/
#https://vip.brunarosso.com/s/designers/s-max-mara/


#https://www.alducadaosta.com/it/donna/designer/studio_max_mara
#https://www.alducadaosta.com/it/donna/designer/weekend_max_mara
#https://www.alducadaosta.com/it/donna/designer/max_mara_the_cube
#https://vip.brunarosso.com/s/designers/max-mara-studio/
#https://vip.brunarosso.com/s/designers/s-max-mara/
#https://www.brunarosso.com/s/designers/max-mara-atelier/
#https://www.blondieshop.com/it/donna/woman-designer/s-max-mara.html
#https://www.blondieshop.com/it/donna/woman-designer/sportmax.html?p=3
#https://eleonorabonucci.com/en/sportmax/women/sale
#https://eleonorabonucci.com/en/sportmax-code/women/sale
#https://www.gebnegozionline.com/it_it/donna/designers/sportmax.html
#https://www.montiboutique.com/it-IT/donna/designer/max_mara
#https://www.tessabit.com/it_it/donna/designers/max-mara.html
#https://www.wiseboutique.com/it_it/donna/designers/max-mara-studio.html
#https://www.wiseboutique.com/it_it/donna/designers/max-mara-studio-elegante.html
