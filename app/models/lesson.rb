class Lesson < ActiveRecord::Base
  has_many :words
  has_many :answers
  belongs_to :category
  belongs_to :user

  validates :title, presence: true
end
