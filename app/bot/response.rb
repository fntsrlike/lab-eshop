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

  def self.postback_payload(action, target_id = nil)
    payload = {}
    payload['action'] = action.upcase
    payload['target'] = target_id if target_id

    payload.to_json
  end
end
