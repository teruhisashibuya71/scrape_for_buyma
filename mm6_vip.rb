
#require ./ファイル名
require './actuelb'
require './auzmendi_f_woman'
require './amr'
require './amr_f_woman'
require './coltorti'
require './gaudenzi'
require './leam'
require './nugnes'
require './russocapri'
require './sigrun'
require './suit'
require './wise_f_woman' #monclerの価格違いあるので

#selenium系
require './alducadaosta'
require './brunarosso_woman'
require './blondie'
require './eleonorabonucci' #サイズ35〜
require './gb_selenium'
require './monti'
require './tessabit'
require './wise'




class MargielaVipWoman
    
    #服 靴 バッグ アクセ の4種類で対応する
    @category = "靴"
    @price = "545"

    #include + クラス名
    include Actuelb
    include Amr
    include AmrFarfetchWoman
    include AuzmendiFarfetchWoman
    include Coltorti
    include Gaudenzi
    include Leam
    include Nugnes
    include Russocapri
    include SigrunWoehr
    include Suit
    include WiseFarfetchWoman

    #seleniumm系
    include Alducadaosta
    include BrunarossoWoman
    include Blondi
    include Eleonorabonucci
    include Gbselenium
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
    "https://www.coltortiboutique.com/it/designer/mm6_maison_margiela?cat=166",
    "https://nugnes1920.com/collections/mm6-maison-margiela-woman",

    #selenium
    "https://www.alducadaosta.com/it/donna/designer/mm6_maison_margiela",
    "https://eleonorabonucci.com/en/mm6-maison-margiela/women/new-collection",
    "https://www.gebnegozionline.com/it_it/donna/designers/mm6-maison-margiela.html",
    "https://www.tessabit.com/it_it/donna/designers/mm6-maison-margiela.html?page=1"
    
]

    mm6_vip_woman = Mm6VipWoman.new
    @price = Mm6VipWoman.call_price
    @category = Mm6VipWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.coltortiboutique.com/it/designer/maison_margiela?cat=166"
            margiela_vip_woman.coltorti_crawl(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://nugnes1920.com/collections/mm6-maison-margiela-woman"
            margiela_vip_woman.nugnes_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        
        #selenium
        when "https://www.alducadaosta.com/it/donna/designer/mm6_maison_margiela"
            margiela_vip_woman.alducadaosta_crawl_selenium(attack_site_url, @price, @category)
            @price = @price.delete(".")
        when "https://eleonorabonucci.com/en/mm6-maison-margiela/women/new-collection"
            margiela_vip_woman.eleonorabonucci_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.gebnegozionline.com/it_it/donna/designers/mm6-maison-margiela.html"
            vip_margiela_woman.gb_crawl_selenium(attack_site_url, @price)
            @price = @price.delete(".")
        when "https://www.tessabit.com/it_it/donna/designers/mm6-maison-margiela.html?page=1"
            margiela_vip_woman.tessabit_crawl(attack_site_url, @price, @category)
            @price = @price.delete(",")
        end
    end



















