require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:operator)
  end

  test "should get index" do
    sign_in users(:john)

    get "index"

    assert_response :success
    assert_assigns :users
  end

  test "should not get index for unauth user" do
    get_index_with_unauth_user(:david)
    get_index_with_unauth_user(:operator)
  end

  test "should get edit" do
    sign_in users(:john)

    get "edit", id: @user

    assert_response :success
    assert_assigns :user
  end

  test "should not get edit for unauth user" do
    get_edit_with_unauth_user(:david)
    get_edit_with_unauth_user(:operator)
  end

  private
    def get_index_with_unauth_user(user)
      sign_in users(user)
      get "index"
      assert_redirected_to root_path
    end

    def get_edit_with_unauth_user(user)
      sign_in users(user)
      get "edit", id: @user
      assert_redirected_to root_path
    end
end
