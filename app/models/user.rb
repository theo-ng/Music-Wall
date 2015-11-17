class User < ActiveRecord::Base
  has_many :tracks
  has_many :votes

  validates :email, presence: true, uniqueness: true, format: { with: /\w+\@\w+\.\w{2,}/ }
  validates :password, presence: true, length: { minimum: 8 }
end