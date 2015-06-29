class Word < ActiveRecord::Base
  belongs_to :category
  has_many :lesson_words, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: lambda {|attribute| attribute[:answer_content].blank?}

  validates :jp_word, presence: true
  validates :category_id, presence: true

  scope :located_in, ->category{where category_id: category.id}
end
