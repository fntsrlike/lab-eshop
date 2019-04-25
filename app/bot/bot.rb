require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger.configure do |config|
  config.provider = MessengerProvider.new
end

Bot.on :message do |request|
  begin
    actions = MessagesController.new(request)

    case request.text
    when 'ping'
      actions.pong
    else
      actions.greeting
    end

  rescue => error
    report_error(error, request)
  end
end

Bot.on :postback do |request|
  begin
    actions = PostbacksController.new(request)

    payload = JSON.parse(request.payload)
    case payload['action']
    when 'PRODUCTS'
      actions.products
    when 'PURCHASE'
      actions.purchase
    when 'CART'
      actions.cart
    when 'REMOVE'
      actions.remove
    when 'ORDERS'
      request.reply Response.plain('這裡是您過去的訂單記錄：')
    end
  end
rescue => error
  report_error(error, request)
end

def report_error(error, message)
  puts error.message
  puts error.backtrace

  if Rails.env.production?
    reply = 'Oops! Bot has some trouble. We will solve it as soon as possible.'
  else
    reply = "An error occurred: #{error.message}"
  end

  message.reply(text: reply)
end
