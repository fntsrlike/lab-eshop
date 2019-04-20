class AddTokenColumnToProvidersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :o_auth_providers, :token, :string
    add_column :o_auth_providers, :expires, :boolean
    add_column :o_auth_providers, :expires_at, :timestamp
  end
end
