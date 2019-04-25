class AddShopReferenceOnOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :shop, index: true
  end
end
