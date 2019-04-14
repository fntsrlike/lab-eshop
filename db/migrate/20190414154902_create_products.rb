class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :shop, foreign_key: true
      t.string :name, null: false, default: 'unnamed'
      t.integer :price, null: false, default: 0
      t.text :desciption
      t.string :image_url
      t.timestamps
    end
  end
end
