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

  def self.carousel(items)
    {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'generic',
          image_aspect_ratio: 'square',
          elements: items
        }
      }
    }
  end

  def self.carousel_item(item, buttons)
    {
      title: item[:title],
      image_url: item[:image_url],
      subtitle: item[:subtitle],
      default_action: {
        type: 'web_url',
        url: item[:image_url],
        webview_height_ratio: 'tall'
      },
      buttons: buttons
    }
  end

  def self.product_item(product)
    item = {
      title: product.name,
      image_url: product.image_url,
      subtitle: product.description,
    }

    buttons = [
      {
        type: 'postback',
        title: 'Purchase',
        payload: postback_payload('PURCHASE', product.id)
      }
    ]

    carousel_item(item, buttons)
  end

  def self.postback_payload(action, target_id = nil)
    payload = {}
    payload['action'] = action.upcase
    payload['target'] = target_id if target_id

    payload.to_json
  end
end
