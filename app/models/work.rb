class Work < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { in: 100..200 }
end
