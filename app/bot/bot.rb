require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger.configure do |config|
  config.provider = MessengerProvider.new
end

Bot.on :message do |request|
  begin
    actions = MessagesController.new(request)

    response = case request.text
    when 'ping'
      actions.pong
    else
      actions.greeting
    end

    request.reply(response)
  rescue => error
    report_error(error, request)
  end
end

Bot.on :postback do |request|
  begin
    payload = JSON.parse(request.payload)

    response = case payload['action']
    when 'PRODUCTS'
      Response.plain('為您展示產品清單：')
    when 'CART'
      Response.plain('以下是您以選購的商品：')
    when 'ORDERS'
      Response.plain('這裡是您過去的訂單記錄：')
    end
  end

  request.reply(response)
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
