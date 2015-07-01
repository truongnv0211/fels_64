class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer_content
      t.integer :word_id
      t.boolean :correct

      t.timestamps null: false
    end
  end
end
