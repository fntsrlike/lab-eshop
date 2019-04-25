class CreateBuyers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyers do |t|
      t.string :provider, null: false, index: true
      t.string :uid, null: false, index: true
      t.timestamps
    end

    add_reference :orders, :buyer, index: true
  end
end
