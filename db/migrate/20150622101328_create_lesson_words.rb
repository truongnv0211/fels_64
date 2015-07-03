class CreateLessonWords < ActiveRecord::Migration
  def change
    create_table :lesson_words do |t|
      t.integer :word_id
      t.integer :lesson_id
      t.integer :answer_id

      t.timestamps null: false
    end
  end
end
