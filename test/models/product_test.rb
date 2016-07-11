require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "title is required" do
    product = Product.new(title: nil)

    assert_not product.save
    assert_includes product.errors.to_h, :title
  end

  test "price is required" do
    product = Product.new(price: nil)

    assert_not product.save
    assert_includes product.errors.to_h, :price
  end

  test "description is not required" do
    product = Product.new(title: "Dummy", price: 10)

    assert product.save
  end

  test "price must be positive" do
    product = Product.new(title: "Dummy", price: -1)
    assert_not product.save

    product.price = -1
    assert_not product.save
  end

  test "comes in many sizes" do
    product = Product.new(title: "Dummy", price: 10)
    product.sizes << sizes(:L)
    product.sizes << sizes(:M)

    assert product.save
    assert_includes sizes(:L).products, product
    assert_includes sizes(:M).products, product
    assert_not_includes sizes(:S).products, product
  end
end
