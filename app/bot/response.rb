class Response
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def copy
    {
      text: "Copy: #{message.text}"
    }
  end
end
