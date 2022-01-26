namespace :daily do
  desc "毎日の三文字の更新"
  task update_three_random_words: :environment do
    puts "started to update random three words."
    Word.update_today_words
    puts "finished to update random three words."
  end
end
