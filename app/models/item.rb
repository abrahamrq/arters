class Item < ActiveRecord::Base
  acts_as_paranoid

  enum status: [:in_stock, :in_shopping_cart ,:sold]
  enum category: [:ceramics, :design, :drawing, :jewellery, :painting,
                :photography, :sculpture, :glass]

  belongs_to :user, inverse_of: :items
  belongs_to :possible_buyer, inverse_of: :expected_items, class_name: 'User'

  validates :user, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :price, presence: true, numericality: true
end
