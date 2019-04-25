class OrdersController < ApplicationController
  def index
    render locals: {orders: current_user.shop.orders}
  end
end
