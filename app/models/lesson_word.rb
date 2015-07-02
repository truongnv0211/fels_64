class LessonWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer

  scope :answered, ->{where Settings.sql_query.answered, :answer}
end
