class ProductsController < ApplicationController
  before_action(:set_resource, only: [:new, :edit])

  def index
    render locals: {products: current_user.shop.products}
  end

  def create
    @resource = current_user.shop.products.new(
      products_params
    )

    if @resource.save
      redirect_to(products_path, notice: 'Resource was successfully created.')
    else
      render(:new)
    end
  end

  private
  def products_params
    params.require(:product)
      .permit(:name, :price, :image_url, :description)
  end

  def set_resource
    if params.key?(:id)
      @resource = Product.find(id: params[:id])
    else
      @resource = Product.new
    end
  end
end
