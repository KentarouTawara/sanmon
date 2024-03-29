class Work < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :user
  has_many :random_words, dependent: :destroy
  has_many :three_words, through: :random_words, source: :word, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { in: 100..200 }
  validates_with WorkValidator

  def show_three_words
    three_words.pluck(:name).join('・')
  end
end
