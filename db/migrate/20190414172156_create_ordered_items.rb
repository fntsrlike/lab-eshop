class CreateOrderedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :ordered_items do |t|
      t.references :product
      t.references :order
      t.integer :amount
      t.timestamps
    end
  end
end
