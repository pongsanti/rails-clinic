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
    get :index, drug_id: @drug
    
    assert_response :success
    assert_assigns :q, :drug, :drug_ins
    assert_equal @drug, a(:drug)
  end

  test "should get index search" do
    get :index, drug_id: @drug, 
      q: { expired_date_lteq: "2015-07-06" }

    assert_response :success
    assert_assigns :q, :drug, :drug_ins
    assert_equal @drug, a(:drug)
    assert_equal 0, a(:drug_ins).count
  end

  test "should get new" do
    get :new, drug_id: @drug

    assert_response :success
    assert_assigns :q, :drug, :drug_in
    assert a(:drug_in).new_record?
  end

  test "should get edit" do
    get :edit, id: @drug_in

    assert_response :success
    assert_assigns :q, :drug, :drug_in
    assert_equal @drug_in, a(:drug_in)
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

  test "should destroy delete" do
    assert_difference 'DrugIn.count', -1 do
      delete :destroy, id: @drug_in
    end

    assert_redirected_to drug_in_drug_movements_url(@drug_in)
    
    @drug_in.reload
    assert_not_nil @drug_in.deleted_at
    assert @drug_in.deleted?
  end

end
