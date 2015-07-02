class Lesson < ActiveRecord::Base
  has_many :words, through: :lesson_words
  has_many :lesson_words
  belongs_to :user
  belongs_to :category

  scope :lessons_learned, ->user{where Settings.sql_query.lessons_learned, user.id}
  scope :following_leaned, ->user{where Settings.sql_query.following_leaned, user.id, user.id}
end
