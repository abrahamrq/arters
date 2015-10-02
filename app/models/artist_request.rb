class ArtistRequest < ActiveRecord::Base
  acts_as_paranoid

  enum status: [:pending, :accepted, :rejected]

  belongs_to :user, inverse_of: :artist_requests

  validates :message, presence: true

end