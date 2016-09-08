require 'test_helper'

class DrugsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @drug = drugs(:one)
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil a(:drugs)
  end

  test "should get index has drug ins" do
    get :index_has_drug_ins, format: :json

    assert_response :success
    assert_not_nil a(:drugs)

    js_res = json_response['drugs'][0]
    assert_not_nil js_res
    assert_not_nil js_res['id']
    assert_not_nil js_res['name']
  end

  test "should get show" do
    get :show, id: @drug
    assert_response :success
    assert_assigns :q, :drug
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_assigns :q, :drug, :drug_usages, :store_units
    assert a(:drug).new_record?
  end

  test "should get edit" do
    get :edit, id: @drug
    assert_response :success
    assert_assigns :q, :drug, :drug_usages, :store_units
    assert_equal @drug, a(:drug)
  end

  test "should post create" do
    assert_difference('Drug.count') do
      post :create, drug: { drug_usage_id: @drug.drug_usage_id, effect: @drug.effect, name: @drug.name, trade_name: @drug.trade_name }
    end

    assert_redirected_to drug_path(assigns(:drug))
    assert_error_div  false
  end

  test "should post create error" do
    assert_no_difference("Drug.count") do
      post :create, drug: { drug_usage_id: @drug.drug_usage_id, effect: @drug.effect, name: "", trade_name: @drug.trade_name }
    end

    assert_response :success
    assert_template :new
    assert_assigns :q, :drug, :drug_usages, :store_units
    assert_error_div true
  end

  test "should patch update" do
    patch :update, id: @drug, drug: { drug_usage_id: @drug.drug_usage_id, effect: @drug.effect, name: @drug.name, trade_name: @drug.trade_name }
    assert_redirected_to drug_path(assigns(:drug))

    assert_assigns :q, :drug
    assert_equal @drug, a(:drug)
    assert_error_div false
  end

  test "should patch update error" do
    patch :update, id: @drug, drug: { drug_usage_id: @drug.drug_usage_id, effect: @drug.effect, name: "", trade_name: @drug.trade_name }
    
    assert_response :success
    assert_template :edit
    assert_assigns :q, :drug, :drug_usages, :store_units
    assert_error_div true
  end  

  test "should delete destroy drug" do
    assert_no_difference('Drug.count') do
      delete :destroy, id: @drug
    end

    assert_redirected_to drugs_path
    @drug.reload
    assert @drug.deleted?
    assert_not_nil @drug.deleted_at
  end

  private
    def json_response
      ActiveSupport::JSON.decode @response.body
    end
end
