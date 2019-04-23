class ShopsController < ApplicationController
  before_action :authenticate_user!

  def index
    provider = current_user.providers.facebook
    pages = get_pages(provider)

    render locals: {provider: provider, pages: pages}
  end

  private
  def get_pages(provider)
    if !provider.expired? && provider.facebook?
      graph = Koala::Facebook::API.new(provider.token)
      pages = graph.get_connections("me", "accounts")
    end
    pages ||= []
  end
end
