require 'test_helper'

class DrugInsControllerTest < ActionController::TestCase
  setup do
    @drug_in = drug_ins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drug_ins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create drug_in" do
    assert_difference('DrugIn.count') do
      post :create, drug_in: { amount: @drug_in.amount, balance: @drug_in.balance, cost: @drug_in.cost, drug_id: @drug_in.drug_id, expired_date: @drug_in.expired_date, sale_price_per_unit: @drug_in.sale_price_per_unit }
    end

    assert_redirected_to drug_in_path(assigns(:drug_in))
  end

  test "should show drug_in" do
    get :show, id: @drug_in
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @drug_in
    assert_response :success
  end

  test "should update drug_in" do
    patch :update, id: @drug_in, drug_in: { amount: @drug_in.amount, balance: @drug_in.balance, cost: @drug_in.cost, drug_id: @drug_in.drug_id, expired_date: @drug_in.expired_date, sale_price_per_unit: @drug_in.sale_price_per_unit }
    assert_redirected_to drug_in_path(assigns(:drug_in))
  end

  test "should destroy drug_in" do
    assert_difference('DrugIn.count', -1) do
      delete :destroy, id: @drug_in
    end

    assert_redirected_to drug_ins_path
  end
end
