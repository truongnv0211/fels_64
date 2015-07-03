class Lesson < ActiveRecord::Base
  has_many :words, through: :lesson_words
  has_many :lesson_words
  belongs_to :user
  belongs_to :category
  accepts_nested_attributes_for :lesson_words
  after_create :random_words

  scope :lessons_learned, ->user{where Settings.sql_query.lessons_learned, user.id}
  scope :following_leaned, ->user{where Settings.sql_query.following_leaned, user.id, user.id}

  private
  def random_words
    self.category.words.sample(20).each {|word| self.lesson_words.create word_id: word.id}
  end
end
