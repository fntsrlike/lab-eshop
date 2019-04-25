class Buyer < ApplicationRecord
  has_many :orders

  def cart(shop)
    orders
      .where(shop: shop, ordered_at: nil)
      .first_or_create(shop: shop)
  end
end
