class Order < ApplicationRecord
  has_many :ordered_items
  has_many :products, through: :ordered_items

  def buy(product)
    item = item(product)
    item.amount += 1
    item.save
  end

  def self.without_deal
    where(ordered_at: nil)
  end

  def size
    ordered_items.size
  end

  def item(product)
    ordered_items.where(product: product).first_or_create
  end

  def caculate_total_cost!
    return unless ordered_at.nil?

    total_cost = 0
    ordered_items.each do |item|
      price = item.product.price
      cost = price * item.amount
      total_cost += cost
    end

    self.update(
      sum: total_cost
    )
  end
end
