require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'


#require ./ファイル名
#require './actuelb'
#require './alducadaosta'
#require './auzmendi_f_man'
#require './auzmendi_f_woman'
#require './amr_f_man'
#require './amr_f_woman'
#require './coltorti'
require './eleonorabonucci_f_man'
#require './eleonorabonucci_f_woman'
#require './gaudenzi'
require './gb_f_man'
#require './gb_f_woman'
#require './leam'
require './nugnes'
#require './russocapri'
#require './sigrun'
#require './suit'
#require './tessabit'
#require './wise'
require './wise_f_man'
#require './wise_f_woman'


#selenium系
#require './brunarosso_man'
#require './brunarosso_woman'
#require './blondie'
#require './eleonorabonucci'
#require './gb'
#require './monti'


#一旦完成
class MarniVipMan
    

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "450"

    #include Actuelb
    #include Alducadaosta
    #include AuzmendiFarfetchman
    #include AuzmendiFarfetchWoman
    #include AmrFarfetchMan
    #include AmrFarfetchWoman
    #include Coltorti
    include EleonorabonucciFarfetchMan
    #include EleonorabonucciFarfetchWoman
    #include Gaudenzi
    include GbFarfetchMan
    #include GbFarfetchWoman
    include Nugnes
    #include Gaudenzi
    #include Russocapri
    #include SigrunWoehr
    #include Suit
    #include Tessabit
    #include Wise
    include WiseFarfetchMan
    #include WiseFarfetchWoman

    
    #seleniumm系
    #include BrunarossoMan
    #include BrunarossoWoman
    #include Blondie
    ##include Eleonorabonucci
    ##include GB
    #include Monti
    

    def self.call_category
        @category
    end


    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.farfetch.com/it/shopping/men/eleonora-bonucci/items.aspx?view=90&scale=282&rootCategory=Men&designer=4224",
    "https://www.farfetch.com/it/shopping/men/G-B/items.aspx?view=90&scale=282&rootCategory=Men&designer=4224",
    "https://nugnes1920.com/collections/marni-man",
    "https://www.farfetch.com/it/shopping/men/wise-boutique/items.aspx?view=90&scale=282&rootCategory=Men&designer=4224",
    #"https://eleonorabonucci.com/en/marni/men/new-collection",
    #"https://eleonorabonucci.com/EN/marni/men/sale"
]

    marni_vip_man = MarniVipMan.new
    @price = MarniVipMan.call_price
    @category = MarniVipMan.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        # when "actuelb" then
        #     marni_vip_man.actuel_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(",")
        #when "https://www.alducadaosta.com/it/donna/designer/stella_mccartney" then
        #    marni_vip_man.alducadaosta_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        # when "auzmendi" then
        #     marni_vip_man.auzumendi_f_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        #when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=180&scale=274&designer=5502" then
        #    marni_vip_man.amr_farfetch_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        #when "https://www.coltortiboutique.com/it/designer/stella_mccartney?cat=166" then
        #    marni_vip_man.coltorti_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/men/eleonora-bonucci/items.aspx?view=90&scale=282&rootCategory=Men&designer=4224" then
            marni_vip_man.elenora_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/men/G-B/items.aspx?view=90&scale=282&rootCategory=Men&designer=4224" then
            marni_vip_man.gbfarfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        # when "gaudenzi" then
        #     marni_vip_man.gaudenzi_crawl(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "https://www.leam.com/it_eu/designer/stella-mccartney-donna.html" then
        #     marni_vip_man.leam_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        when "https://nugnes1920.com/collections/marni-man" then
            marni_vip_man.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        # when "https://www.russocapri.com/it/donna/categorie/shopping/gruppi/nuovi-arrivi?ds=stella-mc-cartney" then
        #     marni_vip_man.russo_crawl(attack_site_url, @price)
        #     #価格調整無し
        # when "sigrun" then
        #     marni_vip_man.sigrun_crawl(attack_site_url, @price)
        #     @price = @price.delete(".")
        #when "https://suitnegozi.com/collections/stella-mccartney-donna" then
        #    marni_vip_man.suit_crawl(attack_site_url, @price)
        #    @price = @price.delete(".")
        #when "https://www.tessabit.com/it/donna/designers/stella-mccartney" then
        #    marni_vip_man.tessabit_crawl(attack_site_url, @price, @category)
        #    @price = @price.delete(",")
        when "https://www.farfetch.com/it/shopping/women/wise-boutique/items.aspx?view=90&scale=274&rootCategory=Women&designer=5502" then
            marni_vip_man.wise_farfetch_crawl(attack_site_url, @price, @price)
            @price = @price.delete(".")
            #selenium
        #when "https://www.brunarosso.com/s/designers/stella-mccartney/?category=women" then
        #    marni_vip_man.brunarosso_crawl_selenium(attack_site_url, @price, @category)
        #    #別の変数に代入して使用しているため調整不要
        #when "https://www.blondieshop.com/it/donna/woman-designer/stella-mccartney.html" then
        #    marni_vip_man.blondie_crawl_selenium(attack_site_url, @price)
        #    @price = @price.delete(".")
        # when "eleonorabonucci" then
        #     marni_vip_man.elenora_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        # when "gb" then
        #     marni_vip_man.gb_crawl_selenium(attack_site_url, @price, @category)
        #     @price = @price.delete(".")
        #when "https://www.montiboutique.com/it-IT/Donna/designer/stella_mccartney" then
        #    marni_vip_man.monti_crawl_selenium(attack_site_url, @price, @category)
        #    @price = @price.delete(".")
        end
    end

