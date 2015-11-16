class Track < ActiveRecord::Base
  validates :song_title, presence: true
  validates :author, presence: true

  validate :check_url

  def check_url
    return true if url == ''
    errors.add(:url, "not a valid url") unless url =~ URI::regexp
  end
end