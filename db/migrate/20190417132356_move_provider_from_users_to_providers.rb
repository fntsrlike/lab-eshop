class MoveProviderFromUsersToProviders < ActiveRecord::Migration[5.2]
  def change
    User.find_each do |user|
      user.providers.create(
        :provider => user.provider,
        :uid => user.uid
      )
    end
  end
end
