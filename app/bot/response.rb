class Response
  attr_reader :message

  def self.plain(text)
    {
      text: text
    }
  end

  def self.buttons(text, buttons)
    {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: text,
          buttons: buttons
        }
      }
    }
  end
end
