class AddDetailsColumnsOnOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :recipient, :string
    add_column :orders, :address, :string
    add_column :orders, :delivered_at, :timestamp, index: true
  end
end
