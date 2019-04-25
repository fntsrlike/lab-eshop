class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  after_save :update_order_total_cost!

  private
  def update_order_total_cost!
    order.caculate_total_cost!
  end
end
