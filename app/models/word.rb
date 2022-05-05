class Word < ApplicationRecord
  validates :name, presence: true

  scope :today_three_words, ->() {
    where("start_at >= ?", Time.zone.now.beginning_of_day)
      .where("end_at <= ?", Time.zone.now.end_of_day)
  }

  class << self
    def update_today_words
      # 過去一週間で選択されていない or 未選択の言葉を抽出
      from = 1.week.ago.beginning_of_day
      to = 1.day.ago.end_of_day
      three_words = Word.where.not(start_at: from..to).or(Word.where(start_at: nil)).order("RANDOM()").limit(3)

      # 今日の言葉にセット
      three_words.each do |word|
        word.start_at = Time.zone.now.beginning_of_day
        word.end_at = Time.zone.now.end_of_day
        word.save!
      end
    end

  end
end
