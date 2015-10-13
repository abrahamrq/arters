class Item < ActiveRecord::Base
  acts_as_paranoid

  enum status: [:in_stock, :chosen, :sold]
  enum category: [:ceramics, :design, :drawing, :jewellery, :painting,
                  :photography, :sculpture, :glass]

  belongs_to :user, inverse_of: :items
  belongs_to :possible_buyer, inverse_of: :expected_items, class_name: 'User'

  validates :user, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :price, presence: true, numericality: true
  validate :not_already_chosen, on: :update

  def already_chosen?
    possible_buyer_id?
  end

  def already_bought?
    buyer_id?
  end

  private

  def not_already_chosen
    return unless changes[:possible_buyer_id]
    unless changes[:possible_buyer_id].include?(nil)
      errors.add(:possible_buyer_id, 'Already chosen by an user')
    end
  end
end
