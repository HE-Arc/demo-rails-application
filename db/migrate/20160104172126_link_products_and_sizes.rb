class LinkProductsAndSizes < ActiveRecord::Migration
  def change
    create_table :products_sizes do |t|
      t.integer :product_id, null: false
      t.integer :size_id, null: false
    end

    add_foreign_key :products_sizes, :products
    add_foreign_key :products_sizes, :sizes
  end
end
