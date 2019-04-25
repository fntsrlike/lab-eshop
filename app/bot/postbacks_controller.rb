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
    item = buyer.cart.item(product)

    reply Response.plain("已為您選購：#{product.name}，您目前共選購 #{item.amount} 件。")
  end

  def cart
    reply Response.cart(buyer.cart)
  end

  private
  def target_id
    payload = JSON.parse(message.payload)
    payload['target']
  end
end
