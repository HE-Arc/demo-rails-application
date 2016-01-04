class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def buy
    flash.notice = "TODO: buy a product #{params[:id]}"

    redirect_to action: :index
  end
end
