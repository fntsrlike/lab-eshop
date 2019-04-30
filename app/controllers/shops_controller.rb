class ShopsController < ApplicationController
  before_action :authenticate_user!

  def index
    pages = []
    subscriptions = []

    provider = current_user.providers.facebook
    if provider
      pages = FacebookUser.new(provider).pages
      subscriptions = Hash[provider.subscriptions.collect { |s| [s.oid , s] } ]
    end

    render locals: {provider: provider, pages: pages, subscriptions: subscriptions}
  end
end
