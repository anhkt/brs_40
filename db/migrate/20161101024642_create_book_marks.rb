class CreateBookMarks < ActiveRecord::Migration[5.0]
  def change
    create_table :book_marks do |t|
      t.integer :mark_type
      t.integer :user_id
      t.integer :book_id
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
    add_index :book_marks, [:user_id, :book_id],
      name: "index_book_mark_unique", unique: true
  end
end
