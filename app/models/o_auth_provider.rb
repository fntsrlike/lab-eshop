class OAuthProvider < ApplicationRecord
  belongs_to :user

  validates_presence_of :uid, :provider
end
