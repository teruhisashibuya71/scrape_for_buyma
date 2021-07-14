require 'rubygems'
require 'nokogiri'
require 'open-uri'
require './dope_f_woman'
require './amr_f_woman'
require './gb_f_woman'
require './monti'
require './alducadaosta'
require './tessabit'
require './wise'
require './gaudenzi'
require './nugnes'
require './blondie_f_woman'
require './coltorti'


#✓dopeファクトリーファクトリーはオリジナルサイトをクロールすること

class MargielaVipWoman
    #include + クラス名
    include DoepFarfetchWoman
    include AmrFarfetchWoman
    include GbFarfetchWoman
    include Monti
    include Alducadaosta
    include Tessabit
    include Wise
    include Gaudenzi
    include Nugnes
    include BlondieFarfetchWoman
    include Coltorti

    #服 靴 バッグ アクセ の4種類で対応する
    #価格入力欄
    @category = "バッグ"
    @price = "1290"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = ["https://www.alducadaosta.com/it/donna/designer/maison_margiela",
                    ##"https://www.brunarosso.com/s/designers/fendi/?category=men",
                    "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=4981",
                    ##"https://www.tessabit.com/it/donna/designers/maison-margiela",
                    "https://asia.nugnes1920.com/collections/maison-margiela-woman",
                    ##"https://www.gaudenziboutique.com/en-IT/women/designer/maison_margiela",
                    "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=166",
                    "https://www.wiseboutique.com/it_it/donna/designers/maison-margiela.html",
                    "https://www.farfetch.com/it/shopping/women/dope-factory/items.aspx?view=90&scale=274&designer=4981",
                    "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&designer=4981",
                    "https://www.montiboutique.com/it-IT/Donna/designer/maison_martin_margiela",
                    "https://www.farfetch.com/it/shopping/women/blondie/items.aspx?view=90&scale=274&designer=4981"
                    ]

    margiela_vip_woman = MargielaVipWoman.new
    @price = MargielaVipWoman.call_price
    @category = MargielaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.alducadaosta.com/it/donna/designer/maison_margiela" then
            margiela_vip_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        #when "https://www.brunarosso.com/s/designers/fendi/?category=men" then
        #    margiela_vip_woman.brunarosso_crowl(attack_site_url, @@price, @@category)
        when "https://www.farfetch.com/it/shopping/women/G-B/items.aspx?view=90&scale=274&designer=4981" then
            margiela_vip_woman.gbfarfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=166" then
            margiela_vip_woman.coltorti_clowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it/donna/designers/maison-margiela" then
            margiela_vip_woman.tessabit_clowl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://asia.nugnes1920.com/collections/maison-margiela-woman" then
            margiela_vip_woman.nugnes_clowl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gaudenziboutique.com/en-IT/women/designer/maison_margiela" then
            margiela_vip_woman.gaudenzi_clowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/maison-margiela.html" then
            margiela_vip_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/dope-factory/items.aspx?view=90&scale=274&designer=4981" then
            margiela_vip_woman.dope_farfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/AMR/items.aspx?view=90&scale=274&designer=4981" then
            margiela_vip_woman.amr_farfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/blondie/items.aspx?view=90&scale=274&designer=4981" then
            margiela_vip_woman.blondie_farfetch_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.montiboutique.com/it-IT/Donna/designer/maison_martin_margiela" then
            margiela_vip_woman.monti_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        end
    end
