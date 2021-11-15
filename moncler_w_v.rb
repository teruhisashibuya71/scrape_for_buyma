require 'rubygems'
require 'nokogiri'
require 'open-uri'


require './actuelb'
require './amr'
require './amr_f_woman'
require './auzmendi_f_woman'
require './coltorti_woman'
require './gaudenzi'
require './leam'
require './nugnes'
require './russocapri'
require './sigrun'
require './suit'
require './wise_f_woman' #価格違いによる

#selenium
require './alducadaosta'
require './blondie'
require './brunarosso_woman'
require './gb'
require './monti'
require './tessabit'
require './wise'




#一旦完成
class MonclerVipWoman

    #服 靴 バッグ アクセ の4種類で対応する
    #価格入力欄
    @category = "服"
    @price = "420"

    #include + クラス名
    include Actuelb
    include Amr
    include AmrFarfetchWoman
    include AuzmendiFarfetchWoman
    include ColtortiWoman
    include Gaudenzi
    include Leam
    include Nugnes
    include Russocapri
    include SigrunWoehr
    include Suit
    include WiseFarfetchWoman
    
    #以下selenium
    include Alducadaosta
    include Blondie
    include BrunarossoWoman
    include Gb
    include Monti
    include Tessabit
    include Wise
    
    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

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
    "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=moncler",
    "https://suitnegozi.com/collections/moncler-donna",
    "https://www.sigrun-woehr.com/en/By-Brand/Moncler/",
    
    #以下selenium
    "https://www.alducadaosta.com/it/donna/designer/moncler",
    "https://www.blondieshop.com/it/donna/woman-designer/moncler.html",
    "https://www.brunarosso.com/s/designers/moncler/?category=women",
    "https://www.gebnegozionline.com/it_it/donna/designers/moncler.html",
    "https://www.montiboutique.com/it-IT/Donna/designer/moncler",
    "https://www.tessabit.com/en_it/woman/designers/moncler.html?page=1",
    "https://www.wiseboutique.com/en_it/donna/designers/moncler.html"
    ]

    moncler_vip_woman = MonclerVipWoman.new
    @price = MonclerVipWoman.call_price
    @category = MonclerVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://actuelb.com/en/88-women-s-moncler" then
            moncler_vip_woman.actuel_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://amrstore.com/collections/moncler" then
            moncler_vip_woman.amr_crawl(attack_site_url, @price)
            @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&rootCategory=Women&designer=4535" then
            moncler_vip_woman.amr_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/be/shopping/women/auzmendi/items.aspx?view=90&scale=274&designer=4535" then
            moncler_vip_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/moncler?cat=166" then
            moncler_vip_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/moncler" then
            moncler_vip_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.leam.com/it_eu/designer/moncler-donna.html" then
            moncler_vip_woman.leam_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/moncler-woman" then
            moncler_vip_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=moncler" then
            moncler_vip_woman.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://suitnegozi.com/collections/moncler-donna" then
            moncler_vip_woman.suit_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Moncler/" then
            moncler_vip_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")
            
            #以下selenium
        when "https://www.alducadaosta.com/it/donna/designer/moncler" then
            moncler_vip_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.blondieshop.com/it/donna/woman-designer/moncler.html" then
            #puts "blondieスタート"
            moncler_vip_woman.blondie_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.brunarosso.com/s/designers/moncler/?category=women" then
            moncler_vip_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #商品価格はそのまま
        when "https://www.gebnegozionline.com/it_it/donna/designers/moncler.html" then
            moncler_vip_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/moncler" then
            moncler_vip_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/en_it/woman/designers/moncler.html?page=1" then
            moncler_vip_woman.tessabit_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")   
        when "https://www.wiseboutique.com/en_it/donna/designers/moncler.html" then
            moncler_vip_woman.wise_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(",")
        end
    end
