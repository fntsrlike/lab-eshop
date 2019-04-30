class User < ApplicationRecord
  has_one :shop
  has_many :providers, foreign_key: "user_id", class_name: "OAuthProvider"

  after_create :create_shop

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def after_database_authentication
    create_shop unless shop
  end
end
