class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :is_admin, default: false
      t.string :password_digest
      t.string :gravatar
      t.string :remember_digest

      t.timestamps
    end
  end
end
