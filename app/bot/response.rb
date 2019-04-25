class Response
  attr_reader :message

  def self.plain(text)
    {
      text: text
    }
  end
end
