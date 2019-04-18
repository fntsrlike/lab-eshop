class HomeController < ApplicationController
  def member
    authenticate_user!
  end

  def shop
    authenticate_user!
    provider = current_user.providers.facebook
    render locals: {provider: provider}
  end
end
