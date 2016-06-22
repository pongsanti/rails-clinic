require 'test_helper'

class DrugUsagesControllerTest < ActionController::TestCase
  setup do
    @drug_usage = drug_usages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drug_usages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create drug_usage" do
    assert_difference('DrugUsage.count') do
      post :create, drug_usage: { code: @drug_usage.code, text: @drug_usage.text }
    end

    assert_redirected_to drug_usage_path(assigns(:drug_usage))
  end

  test "should show drug_usage" do
    get :show, id: @drug_usage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @drug_usage
    assert_response :success
  end

  test "should update drug_usage" do
    patch :update, id: @drug_usage, drug_usage: { code: @drug_usage.code, text: @drug_usage.text }
    assert_redirected_to drug_usage_path(assigns(:drug_usage))
  end

  test "should destroy drug_usage" do
    assert_difference('DrugUsage.count', -1) do
      delete :destroy, id: @drug_usage
    end

    assert_redirected_to drug_usages_path
  end
end
