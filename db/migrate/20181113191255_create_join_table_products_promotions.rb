class CreateJoinTableProductsPromotions < ActiveRecord::Migration[5.2]
  def change
    create_join_table :products, :promotions do |t|
      # t.index [:product_id, :promotion_id]
      # t.index [:promotion_id, :product_id]
    end
  end
end
