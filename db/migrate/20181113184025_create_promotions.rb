class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.string :code
      t.datetime :start_date
      t.datetime :end_date
      t.integer :percent

      t.timestamps
    end
  end
end
