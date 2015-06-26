class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :lesson_id
      t.integer :word_id
      t.integer :answer_choosed

      t.timestamps null: false
    end
  end
end
