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
end
