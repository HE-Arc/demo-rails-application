require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "smoke test on index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:products)
  end
end
