class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :track, :counter_cache => true
end