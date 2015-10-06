class Item < ActiveRecord::Base
  acts_as_paranoid

  enum status: [:in_stock, :out_of_stock]
  enum category: [:ceramics, :design, :drawing, :jewellery, :painting,
                :photography, :sculpture, :glass]

  belongs_to :user, inverse_of: :items

  validates :user, presence: true
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true,
                                                       greater_than: 0 }
  validates :description, presence: true
  validates :image_url, presence: true
end
