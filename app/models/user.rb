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
end
