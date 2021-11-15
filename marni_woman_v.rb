#require './ファイル名'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


require './alducadaosta'
require './auzmendi_f_woman'
require './coltorti'
require './eleonorabonucci_f_woman'
require './gaudenzi'
require './gb_f_woman'
require './tessabit'
require './nugnes'
require './russocapri'
require './sigrun'
require './wise_f_woman'

require './brunarosso_woman'
#require './eleonorabonucci'
#require './gb'
require './monti'
require './wise'







class MarniVipWoman
    
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "550"

    #include + クラス名
    include Alducadaosta
    include AuzmendiFarfetchWoman
    include Coltorti
    include EleonorabonucciFarfetchWoman
    include Gaudenzi
    include GbFarfetchWoman
    include Nugnes
    include Russocapri
    include SigrunWoehr
    
    #以下selenium
    include BrunarossoWoman
    #include Eleonorabonucci
    #include Gb
    include Monti
    #include Wise
    

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.alducadaosta.com/it/donna/designer/marni",
    "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&sort=2&scale=274&designer=4224",
    "https://www.coltortiboutique.com/it/designer/marni_accessori?cat=166",
    #↓eleonorabonucci
    "https://www.farfetch.com/it/shopping/women/eleonora-bonucci/items.aspx?view=90&scale=274&rootCategory=Women&designer=4224",
    "https://www.gaudenziboutique.com/en-it/women/designer/marni",
    #↓gb
    "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&rootCategory=Women&designer=4224",
    "https://nugnes1920.com/collections/marni-woman",
    "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=marni",
    "https://www.sigrun-woehr.com/en/By-Brand/Marni/",
    #↓wise
    "https://www.farfetch.com/it/shopping/women/wise-boutique/items.aspx?view=90&scale=274&rootCategory=Women&designer=4224",
    
    #以下selenium
    "https://www.brunarosso.com/s/designers/marni/?category=women",
    #"準備中  eleonorabonucci"
    #"準備中  https://www.gebnegozionline.com/it_it/donna/designers/marni.html",
    "https://www.montiboutique.com/it-IT/donna/designer/marni"
    #"準備中  https://www.wiseboutique.com/it_it/donna/designers/marni.html"
    ]

    vip_marni_woman = MarniVipWoman.new
    @price = MarniVipWoman.call_price
    @category = MarniVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.alducadaosta.com/it/donna/designer/marni" then
            vip_marni_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&sort=2&scale=274&designer=4224" then
            vip_marni_woman.auzmendi_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/marni_accessori?cat=166" then
            vip_marni_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&sort=2&scale=274&designer=4224" then
            vip_marni_woman.elenora_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-it/women/designer/marni" then
            vip_marni_woman.gaudenzi_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&rootCategory=Women&designer=4224" then
            vip_marni_woman.gbfarfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/marni-woman" then
            vip_marni_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=marni" then
            vip_marni_woman.russo_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Marni/" then
            vip_marni_woman.sigrun_crawl(attack_site_url, @price)
            @price = @price.delete(".")

        #以下selenium
        when "https://www.brunarosso.com/s/designers/marni/?category=women" then
            vip_marni_woman.brunarosso_crawl_selenium(attack_site_url, @price, @category)
            #商品価格はそのまま
        # when "eleonorabonucci" then
        #     vip_stella_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
        #     @price = @price.delete(".")    
        # when "gb" then
        #     vip_stella_woman.gb_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/donna/designer/marni" then
            vip_marni_woman.monti_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "https://www.wiseboutique.com/it_it/donna/designers/marni.html" then
        #     vip_marni_woman.wise_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")        
        end
    end
