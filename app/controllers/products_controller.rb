class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def buy
    raise "TODO"
  end
end
