class BotController
  attr_reader :message

  def initialize(message)
    @message = message
    @graph = Koala::Facebook::API.new(message.access_token)
  end

  protected
  def reply(response)
    message.reply response
  end

  def buyer
    user = @graph.get_object(message.sender['id'])
  end
end
