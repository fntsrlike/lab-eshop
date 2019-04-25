class Buyer < ApplicationRecord
  has_many :orders

  def cart
    orders.where(ordered_at: nil).first_or_create
  end
end
