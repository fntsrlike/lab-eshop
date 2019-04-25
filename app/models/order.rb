class Order < ApplicationRecord
  belongs_to :shop
  belongs_to :buyer
  has_many :ordered_items
  has_many :products, through: :ordered_items

  def buy(product)
    item = find_item_by(product)

    item.amount += 1
    item.save
  end

  def self.without_deal
    where(ordered_at: nil)
  end

  def self.with_deal
    where.not(ordered_at: nil)
  end
  def remove(product)
    ordered_items.where(product: product).first.delete
  end

  def size
    ordered_items.size
  end

  def find_item_by(product)
    ordered_items.where(product: product).first_or_create
  end

  def deal!(name, address = nil)
    caculate_total_cost!

    self.recipient = name
    self.ordered_at = DateTime.now
    self.save
  end

  def caculate_total_cost!
    return unless ordered_at.nil?

    ordered_items.reload

    total_cost = 0
    ordered_items.each do |item|
      next if item.amount < 1
      price = item.product.price
      cost = price * item.amount
      total_cost += cost
    end

    self.update(
      sum: total_cost
    )
  end
end
