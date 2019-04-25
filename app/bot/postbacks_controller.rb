class PostbacksController
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def products
    subscription = Subscription.find_by(oid: message.recipient['id'])
    products = subscription.shop.products

    items = products.map do |product|
      Response.product_item(product)
    end

    reply Response.plain('為您展示產品清單：')
    reply Response.carousel(items)
  end

  private
  def reply(response)
    message.reply response
  end
end
