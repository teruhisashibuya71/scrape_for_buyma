require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'
require 'require_all'
require_all '/Users/ts/Desktop/scrape/vip'

class Mm6VipWoman
    #服 靴 バッグ アクセ の4種類で対応する
    #ruby mm6_v.rb
    @category = "服"
    @price = "350"    
    include Actuelb, Amr, AmrFarfetchWoman, AuzmendiFarfetchWoman, ColtortiWoman, Gaudenzi, Leam, Michelefranzese, Nugnes, Russocapri, SigrunWoehr, Suit, WiseFarfetchWoman
    include Alducadaosta, AngeloMinetti, BrunarossoWoman, Blondie, Eleonorabonucci, Gb, Monti, Tessabit, Wise
    def self.call_category
        @category
    end
    def self.call_price
        @price
    end
end

ATTACK_LIST_URL = [
    "https://www.coltortiboutique.com/it/designer/mm6_maison_margiela?cat=166",
    "https://eleonorabonucci.com/en/mm6-maison-margiela/women/new-collection",
    "https://nugnes1920.com/collections/mm6-maison-margiela-woman",

    #selenium
    "https://www.alducadaosta.com/it/donna/designer/mm6_maison_margiela",
    "https://www.brunarosso.com/designer/494-mm6-maison-margiela-woman",
    "https://www.minettiangeloonline.com/it/woman?idt=556",
    "https://www.gebnegozionline.com/it_it/donna/designers/mm6-maison-margiela.html",
    "http://specialshop.atelier98.net/it/donna-mm6+maison+margiela"

    #"https://www.brunarosso.com/designer/495-mm6-maison-margiela-x-salomon-woman"
]

    mm6_vip_woman = Mm6VipWoman.new
    @price = Mm6VipWoman.call_price
    @category = Mm6VipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=166"
            mm6_vip_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/mm6-maison-margiela/women/new-collection"
            mm6_vip_woman.eleonorabonucci_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://nugnes1920.com/collections/mm6-maison-margiela-woman"
            mm6_vip_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #selenium
        when "https://www.alducadaosta.com/it/donna/designer/mm6_maison_margiela"
            mm6_vip_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.minettiangeloonline.com/it/woman?idt=556"
            mm6_vip_woman.angelo_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/mm6-maison-margiela.html"
            mm6_vip_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "http://specialshop.atelier98.net/it/donna-mm6+maison+margiela"
            vip__woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".") #B2Bサイトはドットなので対応
        end
    end
