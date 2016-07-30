require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @customer = customers(:customer_david)
  end

  test "should get index" do
    get "index"
    assert_response :success
    assert_select "h3 small", I18n.t("customers.index.sub_text")
  end

  test "should get show" do
    get "show", id: @customer.id

    assert_response :success
  end
end
