class MessagesController
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def copy
    text = "Copy: #{message.text}"
    Response.plain(text)
  end

  def pong
    Response.plain('pong')
  end
end
