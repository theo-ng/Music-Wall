class Review < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  validates :content, length: { minimum: 1 }
  validates :rating, inclusion: { in: 1..5 }, presence: true, numericality: true
end