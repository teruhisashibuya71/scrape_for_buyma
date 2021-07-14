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

class MarniVipWoman
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

ATTACK_LIST_URL = ["https://www.alducadaosta.com/it/donna/designer/marni",
                    "https://www.farfetch.com/it/shopping/women/g-b/items.aspx?view=90&scale=274&designer=4224",
                    #https://www.brunarosso.com/s/designers/marni/?category=women
                    #"https://www.russocapri.com/it/tutti/designer/marni/gruppi",
                    #"https://www.sigrun-woehr.com/en/By-Brand/Marni/","
                    #"https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&sort=2&scale=274&designer=4224",
                    #"https://eleonorabonucci.com/en/marni/women/new-collection",
                    "https://nugnes1920.com/collections/marni-woman",
                    "https://www.wiseboutique.com/it_it/donna/designers/marni.html",
                    "https://www.coltortiboutique.com/it/designer/marni_accessori?cat=166",
                    "https://www.montiboutique.com/it-IT/donna/designer/marni",
                    ]

    margiela_vip_woman = MargielaVipWoman.new
    @price = MargielaVipWoman.call_price
    @category = MargielaVipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.alducadaosta.com/it/donna/designer/marni" then
            margiela_vip_woman.alducadaosta_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/g-b/items.aspx?view=90&scale=274&designer=4224" then
            margiela_vip_woman.gbfarfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.russocapri.com/it/tutti/designer/marni/gruppi" then
            margiela_vip_woman.gbfarfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.sigrun-woehr.com/en/By-Brand/Marni/" then
            margiela_vip_woman.gbfarfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.farfetch.com/it/shopping/women/auzmendi/items.aspx?view=90&sort=2&scale=274&designer=4224" then
            margiela_vip_woman.gbfarfetch_crowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/marni-woman" then
            margiela_vip_woman.nugnes_clowl(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/marni/women/new-collection" then
            margiela_vip_woman.tessabit_clowl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        when "https://www.coltortiboutique.com/it/designer/marni_accessori?cat=166" then
            margiela_vip_woman.coltorti_clowl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://www.wiseboutique.com/it_it/donna/designers/marni.html" then
            margiela_vip_woman.wise_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end
