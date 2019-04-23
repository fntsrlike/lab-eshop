class Subscription < ApplicationRecord
   belongs_to :provider, foreign_key: "o_auth_provider_id", class_name: "OAuthProvider"

   validates_presence_of :o_auth_provider_id, :oid, :name
end
