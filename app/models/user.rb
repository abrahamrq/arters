class User < ActiveRecord::Base
  acts_as_paranoid

  has_many :roles, through: :user_roles
  has_many :user_roles, inverse_of: :user
  has_many :artist_requests, inverse_of: :user

  validates :username, presence: true
  validates :name, presence: true
  validates :last_name, presence: true
  validates :password_hash, presence: true, on: :update
  validates :password_salt, presence: true, on: :update
  validates :password, presence: true, on: :create,
                       length: { in: 8..20 }
  validates :password_confirmation, presence: true, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true, scope: :deleted_at }
  validate :valid_confirmation?, on: :create

  attr_accessor :password
  attr_accessor :password_confirmation

  before_create :encrypt
  after_create :create_role

  def full_name
    "#{name} #{last_name}"
  end

  def admin?
    self.roles.where(name: 'admin').any?
  end

  def client?
    self.roles.where(name: 'client').any?
  end

  def artist?
    self.roles.where(name: 'artist').any?
  end

  def main_role
    self.roles.order('id ASC').first.name
  end

  private

  def encrypt
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def create_role
    UserRole.create(user: self, role_id: 3)
  end

  def valid_confirmation?
    valid = password == password_confirmation
    errors.add(:password_confirmation, 'wrong confirmation') unless valid
    return valid
  end
end
