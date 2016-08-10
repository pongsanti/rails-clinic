require 'test_helper'

class DrugInsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers
  
  setup do
    sign_in users(:john)
    
    @drug = drugs(:one)
    @drug.recal_balance
    @drug_in = drug_ins(:one)

  end

  test "should get index" do
    @holder = "holder"

    get :index, drug_id: @drug.id, holder: @holder
    assert_index
  end

  test "should get xhr index" do
    @holder = "holder"

    xhr :get, :index, drug_id: @drug.id, holder: @holder
    assert_index
  end

  test "should get new" do
    get :new, drug_id: @drug.id
    assert_response :success
    assert_not_nil a(:drug_in)
    assert a(:drug_in).new_record?
  end

  test "should create drug_in" do
    drug_balance = @drug.balance
    amount = 50

    post :create, drug_id: @drug.id, amount: amount,
      drug_in: { 
        expired_date: @drug_in.expired_date, 
        cost: @drug_in.cost,
        sale_price_per_unit: @drug_in.sale_price_per_unit,
        drug_id: @drug.id }

    # assertions
    drug_in = DrugIn.last
    assert_redirected_to drug_in_path(drug_in)

    assert_equal 1, drug_in.drug_movements.count, "a drug movement record should be created"
    drug_movement = drug_in.drug_movements.first

    assert_equal amount, drug_in.balance, "the drug in balance should also be updated"
    assert_equal amount, drug_movement.balance, "the drug movement balance should be created"
    assert_equal 0, drug_movement.prev_bal, "the drug movement previous balance should be 0"

    assert_equal drug_balance + amount, drug_in.drug.balance, "drug balance should also be updated"
  end
  
  private
    def assert_index
      assert_response :success
      assert_not_nil a(:drug)
      assert_not_nil a(:holder)
      assert_not_nil a(:q)
      assert_not_nil a(:drug_ins)


      assert_equal @holder, a(:holder)
      assert_equal @drug, a(:drug)
    end 

=begin


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
=end  
end
