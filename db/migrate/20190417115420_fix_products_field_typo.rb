class FixProductsFieldTypo < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :desciption, :description
  end
end
