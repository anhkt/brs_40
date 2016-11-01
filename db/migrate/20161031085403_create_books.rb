class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.float :avg_rates
      t.integer :number_rate_of_book
      t.integer :number_of_page
      t.references :category, foreign_key: true
      t.datetime :publish_date

      t.timestamps
    end
  end
end
