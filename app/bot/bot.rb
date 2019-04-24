require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger.configure do |config|
  config.provider = MessengerProvider.new
end

Bot.on :message do |message|
  begin
    reply = Response.new(message)

    message.reply(reply.copy)
  rescue => error
    report_error(error, message)
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
