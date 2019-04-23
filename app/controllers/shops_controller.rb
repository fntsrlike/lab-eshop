class ShopsController < ApplicationController
  before_action :authenticate_user!

  def index
    provider = current_user.providers.facebook
    pages = FacebookUser.new(provider).pages
    subscriptions = provider.subscriptions.map { |s| s.oid }

    render locals: {provider: provider, pages: pages, subscriptions: subscriptions}
  end
end
