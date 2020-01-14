class Song < ActiveRecord::Base
  # add associations here
  has_many :notes
  belongs_to :genre
  belongs_to :artist
  accepts_nested_attributes_for :notes, :reject_if => proc { |attrs| attrs[:content].blank? }

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist  ? self.artist.name : nil
 end


end
