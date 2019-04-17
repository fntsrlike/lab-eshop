class CreateOAuthProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :o_auth_providers do |t|
      t.references :user, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.timestamps
    end
  end
end
