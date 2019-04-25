class Response
  attr_reader :message
  extend ActionView::Helpers::NumberHelper

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

  def self.cart(order)
    elements = order.ordered_items.map do |item|
      cart_item(item)
    end
    total_cost = number_with_delimiter(order.sum)

    {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'list',
          top_element_style: 'compact',
          elements: elements,
          "buttons": [
            {
              type: 'postback',
              title: "結帳 (NT$ #{total_cost})",
              payload: postback_payload('DEAL', order.id)
            }
          ]
        }
      }
    }
  end

  def self.cart_item(ordered_item)
    product = ordered_item.product
    amount = ordered_item.amount
    price = number_with_delimiter(product.price)
    total_cost = number_with_delimiter(product.price * amount)

    {
      title: "#{product.name}",
      subtitle: "已選購 #{amount} 件，每件 NT$ #{price}，共計 NT$ #{total_cost}。",
      image_url: product.image_url,
      buttons: [
        {
          type: 'postback',
          title: '撤銷本項商品',
          payload: postback_payload('FORGOT', product.id)
        }
      ]
    }
  end

  def self.postback_payload(action, target_id = nil)
    payload = {}
    payload['action'] = action.upcase
    payload['target'] = target_id if target_id

    payload.to_json
  end
end
