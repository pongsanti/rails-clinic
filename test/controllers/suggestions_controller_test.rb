require 'test_helper'

class SuggestionsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
  end

  test "should get provinces" do
    get "provinces"

    assert_response :success
    assert_equal 2, json_response.count
  end 

  test "should get districts" do
    get "districts"

    assert_response :success
    assert_equal 2, json_response.count
  end

  test "should get sub_districts" do
    get "sub_districts"

    assert_response :success
    assert_equal 2, json_response.count
  end


  private
    def json_response
      ActiveSupport::JSON.decode @response.body
    end

end