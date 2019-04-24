require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger.configure do |config|
  config.provider = MessengerProvider.new
end

Bot.on :message do |message|
  message.reply(
    text: "Copy ##{message.sender['id']}: #{message.text} "
   )
end
