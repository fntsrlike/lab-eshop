class ShopsController < ApplicationController
  before_action :authenticate_user!

  def index
    provider = current_user.providers.facebook
    pages = FacebookUser.new(provider).pages

    render locals: {provider: provider, pages: pages}
  end
end
