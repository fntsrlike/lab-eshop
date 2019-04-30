class OrdersController < ApplicationController
  def index
    orders = current_user.shop.orders.with_deal.order('ordered_at DESC')

    render locals: {orders: orders}
  end
end
