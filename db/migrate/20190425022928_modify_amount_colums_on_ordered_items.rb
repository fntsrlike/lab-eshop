class ModifyAmountColumsOnOrderedItems < ActiveRecord::Migration[5.2]
  def change
    change_column :ordered_items, :amount, :integer, default: 0
  end
end
