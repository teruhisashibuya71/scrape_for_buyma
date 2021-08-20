require 'rubygems'
require 'nokogiri'
require 'open-uri'


require './gb'
require './coltorti'
require './alducadaosta'
require './russocapri'
require './suit'
require './sigrun'
require './leam'
require './tessabit'
require './nugnes'
require './blondie'
require './auzmendi_f_woman'
require './actuelb'
require './gaudenzi'
require './amr_f_woman'
require './wise'
require './monti'
require './brunarosso_woman'

#require './blondie_f_woman'


#https://amrstore.com/collections/moncler
#https://www.montiboutique.com/it-IT/Donna/designer/moncler
#https://www.blondieshop.com/it/donna/woman-designer/moncler.html
#https://www.brunarosso.com/s/designers/moncler/


#一旦完成
class MonclerVipWoman
    #include + クラス名
    include Gb
    include Coltorti
    include Alducadaosta
    include Russocapri
    include Suit
    include SigrunWoehr
    include Leam
    include Tessabit
    include Nugnes
    include Blondie
    include AuzmendiFarfetchWoman
    include Actuelb
    include Gaudenzi
    include AmrFarfetchWoman
    include Wise
    include Monti
    include BrunarossoWoman
    
    
    #farfetchにはmonclerがない
    #include MontiFarfetchWoman
    
    #farfetchにはmonclerが無い
    #include BlondieFarfetchWoman 
    


    #服 靴 バッグ アクセ の4種類で対応する
    #価格入力欄
    @category = "服"
    @price = "695"

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    #"https://www.gebnegozionline.com/it_it/donna/designers/moncler.html",
    #"https://www.coltortiboutique.com/it/designer/moncler?cat=166",
    #"https://www.alducadaosta.com/it/donna/designer/moncler",
    #"https://www.farfetch.com/it/shopping/women/bruna-rosso/items.aspx?view=90&scale=274&designer=4535",
    #"https://www.russocapri.com/it/tutti/designer/moncler/gruppi",
    #"https://suitnegozi.com/collections/moncler-donna",
    #"https://www.sigrun-woehr.com/en/By-Brand/Moncler/",
    #"https://www.leam.com/it_eu/designer/moncler-donna.html",
    #"https://www.tessabit.com/it/donna/designers/moncler",
    #"https://nugnes1920.com/collections/moncler-woman",
    #"https://www.blondieshop.com/it/donna/woman-designer/moncler.html",
    #"https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=4535",
    #"https://actuelb.com/en/88-women-s-moncler",
    #"https://www.gaudenziboutique.com/en-it/women/designer/moncler",
    #"https://www.wiseboutique.com/it_it/donna/designers/moncler.html",
    #"https://www.montiboutique.com/it-IT/Donna/designer/moncler"
    "https://www.brunarosso.com/s/designers/moncler/?category=women"

    ]

    moncler_vip_woman = MonclerVipWoman.new
    @price = MonclerVipWoman.call_price
    @category = MonclerVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.gebnegozionline.com/it_it/donna/designers/moncler.html" then
            puts "gb開始"
            moncler_vip_woman.gb_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/moncler?cat=166" then
            puts "coltorti開始"
            moncler_vip_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.alducadaosta.com/it/donna/designer/moncler" then
            puts "alducadaosta開始"
            moncler_vip_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/bruna-rosso/items.aspx?view=90&scale=274&designer=4535" then
            puts "brunarossof開始"
            moncler_vip_woman.bruna_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/tutti/designer/moncler/gruppi" then
            puts "russoスタート"
            moncler_vip_woman.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/moncler-donna" then
            puts "suitスタート"
            moncler_vip_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Moncler/" then
            puts "sigrunスタート"
            moncler_vip_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/moncler-donna.html" then
            puts "leamスタート"
            moncler_vip_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/donna/designers/moncler" then
            puts "tessabitスタート"
            moncler_vip_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://nugnes1920.com/collections/moncler-woman" then
            puts "nugnesスタート"
            moncler_vip_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/donna/woman-designer/moncler.html" then
            puts "blondieスタート"
            moncler_vip_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=4535" then
            puts "azumendiスタート"
            moncler_vip_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://actuelb.com/en/88-women-s-moncler" then
            puts "actuelスタート"
            moncler_vip_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/moncler" then
            puts "gaudenziスタート"
            moncler_vip_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/moncler.html" then
            puts "wiseスタート"
            moncler_vip_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/moncler" then
            moncler_vip_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/moncler/?category=women" then
            moncler_vip_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #商品価格はそのまま
        end
    end
