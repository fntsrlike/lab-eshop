class AddTokenColumnOnSubscribesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :token, :string
  end
end
