class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  ### some high-power Rails magic
  # accepts_nested_attributes_for lets us create multiple Notes when creating a
  # Song. That's pretty awesome. 
  # However we can define a proc (a small in-line method) that is passed the attributes 
  # that are about to be handed to the to-be-created Note and cancel the operation (reject_if) 
  # if they are judged to be invalid 
  # (i.e. the content attribute is empty). Soooo...powerful!
  accepts_nested_attributes_for :notes, :reject_if => proc { |attrs| attrs[:content].blank? }

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    artist.try(:name)
    # same as:
    # artist.nil? ? nil : artist.name
    # reference https://coderwall.com/p/nnmjjq/try-method-do-you-need-it
  end
end
