class OAuthProvider < ApplicationRecord
  belongs_to :user

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
  validates_uniqueness_of :provider, :scope => :user_id

  def self.from_omniauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end

  def self.facebook
    where(provider: 'facebook').first
  end
end
