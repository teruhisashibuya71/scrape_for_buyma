require 'rubygems'
require 'nokogiri'
require 'open-uri'

#./'ファイル名'
require './aldogibilaro'
require './capsel'
require './cortecci'
require './ekseption'
require './grifo'
require './julian'
require './lidia'
require './luisa_world'
require './mycompanero'
require './ottodisapietro'
require './smets'
require './vietti'

#以下selenium
require './credoman'
require './labels'
require './genteroma'
require './papini'
require './pl_line'
require './spinnaker'


class OOOONormalMan

    #服 靴 バッグ アクセ の4種類で対応する
    @category = "服"
    @price = "800"
    
    #include + クラス名
    include Aldogibilaro
    include Capsel
    include Cortecci
    include Ekseption
    include Grifo
    include Julian #0サイズあるよ
    include Lidia
    include LuisaWorld
    include Mycompanero
    include Ottodisapietro
    include Smets
    include Vietti
    
    #selenium
    include Credoman
    include Genteroma
    include Labels
    include Papini
    include Plline
    include Spinnaker
    
    def self.call_category
        @category
    end

    def self.call_price
        @price
    end

end

ATTACK_LIST_URL = [
    "https://www.ekseption.com/ot_es/designers/stone_island?___store=ot_es&___from_store=ot_en",
    "https://www.ekseption.com/ot_en/designers/stone_island_shadow", #shadow
    "https://www.genteroma.com/it/designer/uomo/stone-island.html",
    "https://grifo210.com/en/men/designers/stone-island.html?p=2&sale=0",
    "https://grifo210.com/en/catalog/category/view/s/stone-island-shadow-project/id/449/?sale=0", #shadow
    "https://www.lidiashopping.com/en/IT/men/t/designers/stone-island",
    "https://www.lidiashopping.com/en/IT/men/t/designers/stone-island-shadow-project", #shadow
    "https://www.julian-fashion.com/en-IT/men/designer/stone_island",
    "https://www.julian-fashion.com/en-IT/men/designer/stone_island_shadow_project", #shadow
    "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/stone-island-man",
    "https://www.papinistore.com/en/165_stone-island",
    "https://www.pl-line.com/en/stone-island",
    "https://smets.lu/collections/stone-island/men",
    "https://www.viettishop.com/it/designers/stone-island",
    "https://www.viettishop.com/it/designers/stone-island-shadow-project", #shadow

    #以下selenium
    "https://www.genteroma.com/it/designer/uomo/stone-island.html",
    "https://www.genteroma.com/it/designer/uomo/stone-island-shadow-project.html", #shadow
    "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/stone-island-man",
    "https://www.papinistore.com/en/165_stone-island",
    "https://www.pl-line.com/en/stone-island",
    "https://www.pl-line.com/en/stone-island-shadow-project", #shadow    
]

moncler_n_man = MonclerNormalMan.new
@price = MonclerNormalMan.call_price
@category = MonclerNormalMan.call_category

ATTACK_LIST_URL.each do |attack_site_url|
    case attack_site_url
    when "https://www.ekseption.com/ot_es/designers/stone_island?___store=ot_es&___from_store=ot_en"
        moncler_n_man.ekseption_crawl(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.ekseption.com/ot_en/designers/stone_island_shadow"
      moncler_n_man.ekseption_crawl(attack_site_url, @price)
      @price = @price.delete(",")
    when "https://grifo210.com/en/men/designers/stone-island.html?p=2&sale=0"
        moncler_n_man.grifo_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://grifo210.com/en/catalog/category/view/s/stone-island-shadow-project/id/449/?sale=0"
      moncler_n_man.grifo_crawl(attack_site_url, @price)
      @price = @price.delete(".")
    when "https://www.lidiashopping.com/en/IT/men/t/designers/stone-island"
      moncler_n_man.lidia_crawl(attack_site_url, @price)
      @price = @price.delete(".")
    when "https://www.lidiashopping.com/en/IT/men/t/designers/stone-island-shadow-project"
      moncler_n_man.lidia_crawl(attack_site_url, @price)
      @price = @price.delete(".")
    when "https://www.julian-fashion.com/en-IT/men/designer/stone_island"
        moncler_n_man.julian_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.julian-fashion.com/en-IT/men/designer/stone_island_shadow_project"
      moncler_n_man.julian_crawl(attack_site_url, @price)
      @price = @price.delete(".")
    when "https://smets.lu/collections/stone-island/men"
        moncler_n_man.smets_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.viettishop.com/it/designers/stone-island"
        moncler_n_man.vietti_crawl(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.viettishop.com/it/designers/stone-island-shadow-project"
      moncler_n_man.vietti_crawl(attack_site_url, @price)
      @price = @price.delete(".")
    
    #以下selenium
    when "https://www.genteroma.com/it/designer/uomo/stone-island.html"
        moncler_n_man.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
      when "https://www.genteroma.com/it/designer/uomo/stone-island-shadow-project.html"
        moncler_n_man.gente_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(".")
    when "https://www.ottodisanpietro.com/eu_en/man-fashion/man-designers/stone-island-man"
        moncler_n_man.ottodisapietro_crawl_selenium(attack_site_url, @price)
        @price = @price.delete(",")
    when "https://www.papinistore.com/en/165_stone-island"
        moncler_n_man.papini_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    when "https://www.pl-line.com/en/stone-island"
        moncler_n_man.plline_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
      when "https://www.pl-line.com/en/stone-island-shadow-project"
        moncler_n_man.plline_crawl_selenium(attack_site_url, @price)
        #小数点削除必要無し
    end
end