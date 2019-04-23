class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :o_auth_provider, foreign_key: true,  null: false
      t.string :name, null: false
      t.string :oid, null: false
      t.timestamps
    end
  end
end
