require 'rubygems'
require 'nokogiri'
require 'open-uri'


require './mycompanero'


#✓dopeファクトリーファクトリーはオリジナルサイトをクロールすること

class MonclerNormalWoman
    #include + クラス名
    include Mycompanero

    #服 靴 バッグ アクセ の4種類で対応する
    #価格入力欄
    @category = "バッグ"
    @price = "688"

    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = ["https://www.mycompanero.com/fr/brand/2-moncler?categories=femme"
                    ]

    moncler_n_woman = MonclerNormalWoman.new
    @price = MonclerNormalWoman.call_price
    @category = MonclerNormalWoman.call_category

    ATTACK_LIST_URL.each do |attack_site_url|
        case attack_site_url
        when "https://www.mycompanero.com/fr/brand/2-moncler?categories=femme" then
            moncler_n_woman.mycompanero_crawl(attack_site_url, @price)
            @price = @price.delete(".")
        end
    end
