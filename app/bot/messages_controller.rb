class MessagesController < BotController
  def copy
    text = "Copy: #{message.text}"
    reply Response.plain(text)
  end

  def pong
    reply Response.plain('pong')
  end

  def greeting
    text = "#{buyer['first_name']} 您好，很高興為您服務。請問有什麼需要協助的嗎？"
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

    reply Response.buttons(text, buttons)
  end
end
