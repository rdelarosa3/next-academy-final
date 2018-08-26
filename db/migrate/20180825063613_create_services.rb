class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :type
      t.string :name
      t.text :description
      t.integer :price
      t.time :length

      t.timestamps
    end
  end
end
