class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  validates :email, format: {with: VALID_EMAIL_REGEX},
                    presence: true, length: {maximum: 255},
                    uniqueness: {case_sensitive: false}
  validates :username, presence: true, length: {maximum: 50}
end
