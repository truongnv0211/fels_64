class Word < ActiveRecord::Base
  belongs_to :category
  has_many :lessons, through: :lesson_words
  has_many :lesson_words, dependent: :destroy

  validates :jp_word, presence: true
  validates :correct_answer, presence: true, numericality: {only_integer: true}
end
