require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  test "should get index" do
    sign_in users(:john)

    get "index"
    assert_response :success
    assert_select "h3 small", I18n.t("customers.index.sub_text")
  end
end
