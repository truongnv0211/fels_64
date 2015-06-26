class Answer < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word

  validates :answer_choosed, presence: true
end
