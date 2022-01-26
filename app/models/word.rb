class Word < ApplicationRecord
  validates :name, presence: true

  scope :today_three_words, ->() {
    where("start_at >= ?", Time.zone.now.beginning_of_day)
      .where("end_at <= ?", Time.zone.now.end_of_day)
  }

  class << self
    def update_today_words
      three_words = Word.order("RANDOM()").limit(3)
      three_words.each do |word|
        word.start_at = Time.zone.now.beginning_of_day
        word.end_at = Time.zone.now.end_of_day
        word.save!
      end
    end

  end
end
