class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :description
      t.string :address

      t.timestamps
    end
  end
end
