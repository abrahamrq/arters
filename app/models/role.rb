class Role < ActiveRecord::Base
  acts_as_paranoid

  has_many :users, through: :user_roles
  has_many :user_roles, inverse_of: :role

  validates :name, presence: true
end