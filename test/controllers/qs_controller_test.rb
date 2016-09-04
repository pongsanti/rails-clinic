require 'test_helper'

class QsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @q = qs(:one)
    @exam = exams(:exam_one)
  end

  test "should xhr get index" do
    xhr :get, "index"

    assert_response :success
    assert_assigns :qs
    assert_equal 3, a(:qs).count
  end

  test "should xhr post create" do
    assert_difference "Q.count", 1 do
      xhr :post, "create", exam_id: @exam.id
    end

    assert_response :success
  end

  test "should xhr delete destroy" do
    assert_difference "Q.count", -1 do
      xhr :delete, "destroy", id: @q.id
    end

    assert_response :success
  end

end