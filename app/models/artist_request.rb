class ArtistRequest < ActiveRecord::Base
  acts_as_paranoid

  enum status: [:pending, :accepted, :rejected]

  belongs_to :user, inverse_of: :artist_requests

  validates :message, presence: true

  def authorize_user
  	UserRole.create(user: self.user, role_id: 2) if accepted?
  end
end