class Lesson < ActiveRecord::Base
  has_many :words, through: :lesson_words
  has_many :lesson_words
  belongs_to :user
  belongs_to :category
end
