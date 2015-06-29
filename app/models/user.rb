class User < ActiveRecord::Base
  attr_accessor :remember_token

  before_save ->{self.email = email.downcase}

  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
            foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
            foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  mount_uploader :picture, PictureUploader

  validates :email, format: {with: Settings.VALID_EMAIL_REGEX},
            presence: true, length: {maximum: Settings.email_maximum},
            uniqueness: {case_sensitive: false}
  validates :username, presence: true, length: {maximum: Settings.name_maximum}
  validates :password, presence: true,
            length: {minimum: Settings.password_minimum}, allow_nil: true
  validate  :picture_size

  has_secure_password

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def picture_size
    if picture.size > Settings.image_size_accept.megabytes
      errors.add :picture, t(:image_size_error)
    end
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end
end
