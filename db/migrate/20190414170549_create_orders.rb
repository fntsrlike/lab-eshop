class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :sum
      t.timestamp :ordered_at
      t.timestamps
    end
  end
end
