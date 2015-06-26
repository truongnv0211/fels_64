class Word < ActiveRecord::Base
  belongs_to :lessons
  has_many :answers, dependent: :destroy

  validates :jp_word, presence: true
  validates :correct_answer, presence: true, numericality: {only_integer: true}
end
