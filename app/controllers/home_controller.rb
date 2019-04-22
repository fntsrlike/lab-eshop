class HomeController < ApplicationController
  def member
    authenticate_user!
  end

  def shop
    authenticate_user!
    provider = current_user.providers.facebook

    pages = []
    if !provider.expired? && provider.facebook?
      graph = Koala::Facebook::API.new(provider.token)
      pages = graph.get_connections("me", "accounts")
    end

    render locals: {provider: provider, pages: pages}
  end
end
