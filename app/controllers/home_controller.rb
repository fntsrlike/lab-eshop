class HomeController < ApplicationController
  def member
    authenticate_user!
  end
end
