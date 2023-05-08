require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class VipMan
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby
    @category = "靴"
    @price = "550"
    @currency = 
    include Actuelb, Amr, AmrFarfetchMan, AuzmendiFarfetchMan, ColtortiMan, Eleonorabonucci, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, Suit
    include Alducadaosta, AngeloMinetti, BrunarossoMan, Blondie, Gb, Monti, Tessabit, Wise
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
        https://www.coltortiboutique.com/it/designer/mm6_maison_margiela?ca_gender=1996
        https://eleonorabonucci.com/en/mm6-maison-margiela/men
        https://nugnes1920.com/collections/mm6-maison-margiela-man


        selenium系サイトのブランド一覧
        https://www.alducadaosta.com/it/uomo/designers
        https://www.minettiangeloonline.com/it/register.html
        https://www.brunarosso.com/s/designers/?gender=men
        https://www.blondieshop.com/it/man/man-designer.html
        https://www.gebnegozionline.com/it_it/uomo/designers
        https://www.montiboutique.com/it-IT/uomo/designers
        http://specialshop.atelier98.net/it/register.html
        https://www.wiseboutique.com/it_it/uomo/designers

    ]

    _man = VipMan.new
    @price = VipMan.call_price
    @category = VipMan.call_category
    @currency = VipMan.call_currency

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when ""
            _man.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            _man.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when ""
            _man.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when ""
            _man.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when ""
            _man.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when ""
            _man.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",") #修正済みのため正
        when ""
            _man.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when ""
            _man.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.michele_crawl(attack_site_url, @price, @currency)
            #価格調整無し
        when ""
            _man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.russo_crawl(attack_site_url, @price)
            #価格調整無し
        when ""
            _man.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
        #以下selenium
        when ""
            _man.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "" 
            _man.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #調整不要
        when ""
            _man.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when ""
            _man.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when 
            _man.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        when ""
            _man.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
end