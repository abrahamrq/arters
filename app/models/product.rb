class Product < ActiveRecord::Base
  acts_as_paranoid

  enum status: [:in_stock, :out_of_stock]

  belongs_to :user, inverse_of: :products

  validates :user, presence: true
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true,
  																										 greater_than: 0 }
  validates :description, presence: true
  validates :image_url, presence: true

  def authorize_user
  	UserRole.create(user: self.user, role_id: 2) if accepted?
  end
end