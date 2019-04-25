class PostbacksController < BotController
  def products
    subscription = Subscription.find_by(oid: oid)
    products = subscription.shop.products

    if products.count = 0
      reply Response.plain('抱歉，本店還未將商品上架。')
    else
      items = products.map do |product|
        Response.product_item(product)
      end

      reply Response.plain('為您展示產品清單：')
      reply Response.carousel(items)
    end
  end

  def purchase
    product = Product.find(target_id)
    cart.buy(product)
    item = cart.find_item_by(product)

    reply Response.plain("已為您選購：#{product.name}，您目前共選購 #{item.amount} 件。")
  end

  def show_cart
    if cart.size > 0
      reply Response.cart(cart)
    else
      reply Response.plain("您的購物車目前沒有商品。")
    end
  end

  def remove
    product = Product.find(target_id)
    cart.remove(product)

    reply Response.plain("已為您撤銷：#{product.name}。")
    cart
  end

  def deal
    if cart.size > 0
      total_cost = cart.sum
      cart.deal!(user['first_name'])
      reply Response.plain("已為您結帳，總共是 #{total_cost} 元。")
      reply Response.plain("本機器人尚未實作填寫住址與付費功能，感謝您的試用。")
    else
      reply Response.plain("您的購物車目前沒有商品。")
    end
  end

  def orders
    reply Response.plain('這裡是您最近三筆的訂單記錄：')
    orders = buyer.orders
      .with_deal
      .where(shop: shop)
      .order('ordered_at DESC')
      .limit(3)
      .all

    orders.each do |order|
      reply Response.ordered_at(order)
      reply Response.receipt(order)
    end
  end

  private
  def target_id
    payload = JSON.parse(message.payload)
    payload['target']
  end
end
