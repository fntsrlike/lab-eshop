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
      actions.copy
    end

    request.reply(response)
  rescue => error
    report_error(error, request)
  end
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
