require 'test_helper'

class DrugUsagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @drug_usage = drug_usages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_assigns :q, :drug_usages
  end

  test "should get show" do
    get :show, id: @drug_usage

    assert_response :success
    assert_assigns :q, :drug_usage
  end

  test "should get new" do
    get :new

    assert_response :success
    assert_assigns :q, :drug_usage
    assert a(:drug_usage).new_record?
  end

  test "should get edit" do
    get :edit, id: @drug_usage

    assert_response :success
    assert_assigns :q, :drug_usage
    assert_equal @drug_usage, a(:drug_usage)
  end

  test "should post create" do
    assert_difference('DrugUsage.count') do
      post :create, drug_usage: { code: @drug_usage.code, text: @drug_usage.text }
    end

    assert_redirected_to drug_usage_path(a(:drug_usage))
    assert_error_div false
  end

  test "should post create error" do
    assert_no_difference("DrugUsage.count") do
      post :create, drug_usage: { code: @drug_usage.code, text: "" }
    end

    assert_assigns :q, :drug_usage
    assert_response :success
    assert_template :new

    assert_error_div true
  end

  test "should patch update" do
    patch :update, id: @drug_usage, drug_usage: { code: "code", text: "text" }

    assert_redirected_to drug_usage_path(a(:drug_usage))
    assert_assigns :q, :drug_usage
    assert_equal "code", a(:drug_usage).code
    assert_equal "text", a(:drug_usage).text

    assert_error_div false
  end

  test "should patch update error" do
    patch :update, id: @drug_usage, drug_usage: { code: "", text: "text" }

    assert_response :success
    assert_template :edit
    assert_assigns :q, :drug_usage
    assert_equal @drug_usage, a(:drug_usage)

    assert_error_div true
  end
  
  test "should delete destroy" do
    delete :destroy, id: @drug_usage
    
    assert_redirected_to drug_usages_path

    @drug_usage.reload
    assert @drug_usage.deleted?
    assert_not_nil @drug_usage.deleted_at

  end

end