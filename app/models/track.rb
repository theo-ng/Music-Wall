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
      Track.select("tracks.*, COUNT(votes.id) AS votes").joins("LEFT OUTER JOIN votes ON votes.track_id = tracks.id").group("tracks.id").order("votes DESC")
    end
  end
end