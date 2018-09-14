class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :email, null: false
      t.string :gender
      t.date :birthday
      t.string :phone_number
      t.integer :role, default: 0
      t.string :avatar
      t.text :notes
      t.string :encrypted_password, limit: 128, null: false
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128, null: false
      t.timestamps null: false
    end

    add_index :users, :email
    add_index :users, :remember_token
  end
end
