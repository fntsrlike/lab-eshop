class SubscriptionsController < ApplicationController
  def create
    provider = OAuthProvider.find(subscription_params[:provider_id])

    if provider.user != current_user
      message = '您沒有這個 Provider 的權限。'
      return redirect_to(shop_path, alert: message)
    end

    page_id = subscription_params[:oid]
    pages = FacebookUser.new(provider).pages.select do |page|
      page['id'] == page_id
    end

    if pages.size == 0
      message = '您沒有這個粉絲專頁的權限，請再次確認或重新授權。'
      return redirect_to(shop_path, alert: message)
    end

    page = pages.first
    response = subscribe_page(page)
    unless response['success']
      message = "訂閱失敗！錯誤代號為 #{response['code']}，請洽系統管理員處理。"
      return redirect_to(shop_path, alert: message)
    end

    subscription = provider.subscriptions.where(oid: page['id']).first_or_create
    subscription.name = page['name']
    subscription.token = page['access_token']
    subscription.save if subscription.changed?

    message = "成功訂閱粉絲專頁 #{page['name']}！"
    redirect_to(shop_path, notice: message)
  end

  private
  def subscription_params
    params.permit(:provider_id, :oid, :name, :token)
  end

  def subscribe_page(page)
    subscribed_fields = [
      'messages',
      'message_deliveries',
      'messaging_postbacks'
    ]
    graph = Koala::Facebook::API.new(page['access_token'])
    graph.put_connections(page['id'], 'subscribed_apps', subscribed_fields: subscribed_fields)
  end
end
