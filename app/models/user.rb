class User < ActiveRecord::Base
  before_save ->{self.email = email.downcase}

  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
            foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  validates :email, format: {with: Settings.VALID_EMAIL_REGEX},
            presence: true, length: {maximum: Settings.email_maximum},
            uniqueness: {case_sensitive: false}
  validates :username, presence: true, length: {maximum: Settings.name_maximum}
  validates :password, presence: true,
            length: {minimum: Settings.password_minimum}

  has_secure_password

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def self.new_token
    SeureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes :remember_digest, User.digest(remember_token)
  end
end
