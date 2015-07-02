class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :lesson_words, dependent: :destroy
end
