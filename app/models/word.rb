class Word < ApplicationRecord
  validates :name, presence: true

  scope :today_three_words, ->() {
    start_at = Time.zone.now.beginning_of_day  + 5.hours
    end_at = start_at + 24.hours
    where("start_at >= ?", start_at)
      .where("end_at <= ?", end_at)
  }

  class << self
    def update_today_words
      # 過去一週間で選択されていない or 未選択の言葉を抽出 or active: true
      from = 1.week.ago.beginning_of_day
      to = 1.day.ago.end_of_day
      three_words = Word.where.not(start_at: from..to).or(Word.where(start_at: nil))
                        .where(active: true)
                        .order("RANDOM()").limit(3)

      # 今日の言葉にセット.毎日5時に発動
      three_words.each do |word|
        start_at = Time.zone.now.beginning_of_day  + 5.hours
        end_at = start_at + 24.hours

        word.start_at = start_at
        word.end_at = end_at
        word.save!
      end
    end
  end
end
