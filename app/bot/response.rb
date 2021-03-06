class Response
  attr_reader :message
  extend ActionView::Helpers::NumberHelper
  extend ActionView::Helpers::DateHelper

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
    deal_button = {
      type: 'postback',
      title: "結帳 (NT$ #{total_cost})",
      payload: postback_payload('DEAL', order.id)
    }

    if elements.size > 1
      {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'list',
            top_element_style: 'compact',
            elements: elements,
            "buttons": [deal_button]
          }
        }
      }
    else
      elements.first[:buttons].push(deal_button)
      {
        attachment: {
          type: 'template',
          payload: {
            template_type: 'generic',
            elements: elements
          }
        }
      }
    end
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
          payload: postback_payload('REMOVE', product.id)
        }
      ]
    }
  end

  def self.ordered_at(order)
    time = distance_of_time_in_words(order.ordered_at, DateTime.now)
    {
      text: "成交於 #{time}。"
    }
  end

  def self.receipt(order)
    elements = order.ordered_items.map do |item|
      receipt_item(item)
    end
    {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'receipt',
          recipient_name: order.recipient,
          order_number: order.id,
          currency: 'TWD',
          payment_method: '<UNDEFINED_PAYMENT>',
          timestamp: order.ordered_at.to_i,
          summary:{
            total_cost: order.sum
          },
          elements: elements
        }
      }
    }
  end

  def self.receipt_item(ordered_item)
    product = ordered_item.product
    {
      title: product.name,
      subtitle: product.description,
      quantity: ordered_item.amount,
      price: product.price,
      currency: 'TWD',
      image_url: product.image_url
    }
  end

  def self.postback_payload(action, target_id = nil)
    payload = {}
    payload['action'] = action.upcase
    payload['target'] = target_id if target_id

    payload.to_json
  end
end
