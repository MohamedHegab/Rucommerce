class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price, precision: 4, scale: 3
      t.references :department, index: true

      t.timestamps
    end
  end
end
