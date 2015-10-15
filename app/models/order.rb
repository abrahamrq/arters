class Order < ActiveRecord::Base
  acts_as_paranoid
  after_create :set_items

  belongs_to :user, inverse_of: :orders
  has_many :items, inverse_of: :order

  validates :user, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :zip_code, presence: true, length: { in: 5..10 }

  private

  def set_items
  	items = self.user.expected_items
  	items.each do |item|
  		item.possible_buyer_id = nil
  		item.buyer_id = self.user_id
  		item.order_id = self.id
  		item.save(validate: false)
  	end
  end
end
