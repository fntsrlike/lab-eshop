class BotController
  attr_reader :message, :oid, :subscription, :shop, :user, :buyer

  def initialize(message)
    @message = message
    @graph = Koala::Facebook::API.new(message.access_token)

    @oid = message.recipient['id']
    @subscription = Subscription.find_by(oid: oid)
    @shop = @subscription.shop
    @user = @graph.get_object(message.sender['id'])
    @buyer = Buyer.where(
      provider: 'facebook',
      uid: user['id']
    ).first_or_create
  end

  protected
  def reply(response)
    message.reply response
  end

  def cart
    buyer.cart(shop)
  end
end
