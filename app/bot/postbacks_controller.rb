class PostbacksController < BotController
  def products
    subscription = Subscription.find_by(oid: message.recipient['id'])
    products = subscription.shop.products

    items = products.map do |product|
      Response.product_item(product)
    end

    reply Response.plain('為您展示產品清單：')
    reply Response.carousel(items)
  end

  def purchase
    product = Product.find(target_id)
    buyer.cart.buy(product)
    item = buyer.cart.find_item_by(product)

    reply Response.plain("已為您選購：#{product.name}，您目前共選購 #{item.amount} 件。")
  end

  def cart
    if buyer.cart.size > 0
      reply Response.cart(buyer.cart)
    else
      reply Response.plain("您的購物車目前沒有商品。")
    end
  end

  def remove
    product = Product.find(target_id)
    buyer.cart.remove(product)

    reply Response.plain("已為您撤銷：#{product.name}。")
    cart
  end

  private
  def target_id
    payload = JSON.parse(message.payload)
    payload['target']
  end
end
