class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.integer :user_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
