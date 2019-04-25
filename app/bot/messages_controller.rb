class MessagesController
  attr_reader :message

  def initialize(message)
    @message = message
    @graph = Koala::Facebook::API.new(message.access_token)
  end

  def copy
    text = "Copy: #{message.text}"
    Response.plain(text)
  end

  def pong
    Response.plain('pong')
  end

  def greeting
    text = "#{username} 您好，很高興為您服務。請問有什麼需要協助的嗎？"
    buttons = [
      {
        type: 'postback',
        title: '產品清單',
        payload: Response.postback_payload('PRODUCTS')
      },
      {
        type: 'postback',
        title: '購物車',
        payload: Response.postback_payload('CART')
      },
      {
        type: 'postback',
        title: '訂單記錄',
        payload: Response.postback_payload('ORDERS')
      }
    ]

    Response.buttons(text, buttons)
  end

  private
  def username
    user = @graph.get_object(message.sender['id'])
    user['first_name']
  end
end
