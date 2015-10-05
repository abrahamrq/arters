class UserRole < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user, inverse_of: :user_roles
  belongs_to :role, inverse_of: :user_roles
end
