class Track < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  
  validates :song_title, presence: true
  validates :author, presence: true

  validate :check_url

  def check_url
    return true if url == ''
    errors.add(:url, "not a valid url") unless url =~ URI::regexp
  end

  class << self
    def ordered_list
      Track.all.order("votes_count DESC")
    end
  end
end