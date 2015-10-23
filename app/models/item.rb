class Item < ActiveRecord::Base
  acts_as_paranoid

  enum status: [:in_stock, :chosen, :sold]
  enum category: [:ceramics, :design, :drawing, :jewellery, :painting,
                  :photography, :sculpture, :glass]

  belongs_to :user, inverse_of: :items
  belongs_to :order, inverse_of: :items

  validates :user, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :price, presence: true, numericality: true
  validate :not_already_chosen, on: :update
  validate :yours?, on: :update
  validate :update_in_stock, on: :update

  def possible_buyer
    User.find_by_id(possible_buyer_id)
  end

  def already_chosen?
    possible_buyer_id?
  end

  def already_bought?
    buyer_id?
  end

  private

  def yours?
    return unless changes[:possible_buyer_id]
    if changes[:possible_buyer_id][1] == self.user_id
      errors.add(:possible_buyer_id, 'You are the owner of these item')
    end
  end

  def not_already_chosen
    return unless changes[:possible_buyer_id]
    unless changes[:possible_buyer_id].include?(nil)
      errors.add(:possible_buyer_id, 'Already chosen by an user')
    end
  end

  def update_in_stock
    return if in_stock?
    errors.add(:status, "Unable to edit an item that is "\
                        "sold or in a shopping cart")
  end
end
