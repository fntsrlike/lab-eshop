class ShopsController < ApplicationController
  before_action :authenticate_user!

  def index
    provider = current_user.providers.facebook

    pages = []
    if !provider.expired? && provider.facebook?
      graph = Koala::Facebook::API.new(provider.token)
      pages = graph.get_connections("me", "accounts")
    end

    render locals: {provider: provider, pages: pages}
  end
end
