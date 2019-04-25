class Order < ApplicationRecord
  has_many :ordered_items
  has_many :products, through: :ordered_items

  def buy(product)
    item = item(product)
    item.amount += 1
    item.save
  end

  def item(product)
    ordered_items.where(product: product).first_or_create
  end
end
