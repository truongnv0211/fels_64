class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :jp_word
      t.integer :correct_answer
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3
      t.string :answer_4
      t.integer :lesson_id

      t.timestamps null: false
    end
  end
end
