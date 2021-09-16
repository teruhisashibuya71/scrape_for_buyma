moji = "string string"


if (moji.include?(" "))
    puts moji.gsub(/\s/, '')
end




#本日の学び 30日 credomanにて
#1.スペースの置き換えと削除    置き換え → 変数.gsub(/\s/, '%20')    削除 → 変数.gsub(/\s/, '')
#2.clickメソッドはdoc.css('li')には使えない→ 必ず driver.find_element(:class, '')に使う

