class ProductsController < ApplicationController
  before_action(:set_resource, only: [:new, :edit])

  def index
  end

  private
  def set_resource
    if params.key?(:id)
      @resource = Product.find(id: params[:id])
    else
      @resource = Product.new
    end
  end
end
