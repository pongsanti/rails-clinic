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

  test "should route correctly" do
    opts = {controller: "drug_ins"}
    drug_id = "1"
    drug_in_id = "2"
    #index
    assert_routing route_path(:get, "/drugs/1/drug_ins"), opts.merge(action: "index", drug_id: drug_id)
    #new
    assert_routing route_path(:get, "/drugs/1/drug_ins/new"), opts.merge(action: "new", drug_id: drug_id)
    #edit
    assert_routing route_path(:get, "/drug_ins/2/edit"), opts.merge(action: "edit", id: drug_in_id)
    #create
    assert_routing route_path(:post, "/drugs/1/drug_ins"), opts.merge(action: "create", drug_id: drug_id)
    #update
    assert_routing route_path(:patch, "/drug_ins/2"), opts.merge(action: "update", id: drug_in_id)
    #destroy
    assert_routing route_path(:delete, "/drug_ins/2"), opts.merge(action: "destroy", id: drug_in_id)
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

  test "should post create" do
    drug_balance = @drug.balance
    amount = 50

    post :create, drug_id: @drug,
      drug_in: { 
        amount: amount,
        expired_date: @drug_in.expired_date, 
        cost: @drug_in.cost,
        sale_price_per_unit: @drug_in.sale_price_per_unit}

    # assertions
    drug_in = DrugIn.last
    assert_redirected_to drug_in_drug_movements_url(drug_in)

    assert_equal 1, drug_in.drug_movements.count, "a drug movement record should be created"
    drug_movement = drug_in.drug_movements.first

    assert_equal amount, drug_in.balance, "the drug in balance should also be updated"
    assert_equal amount, drug_movement.balance, "the drug movement balance should be created"
    assert_equal 0, drug_movement.prev_bal, "the drug movement previous balance should be 0"

    assert_equal drug_balance + amount, drug_in.drug.balance, "drug balance should also be updated"

    assert_error_div false
  end

  test "should post create error" do
    drug_balance = @drug.balance
    
    assert_no_difference "DrugIn.count" do
      post :create, drug_id: @drug,
        drug_in: { 
          amount: nil,
          expired_date: @drug_in.expired_date, 
          cost: @drug_in.cost,
          sale_price_per_unit: @drug_in.sale_price_per_unit}
    end

    assert_response :success
    assert_template :new

    assert_error_div true
  end

  test "should patch update" do
    patch :update, id: @drug_in,
      drug_in: {
        expired_date: @drug_in.expired_date, 
        cost: 500,
        sale_price_per_unit: @drug_in.sale_price_per_unit }
  
    @drug_in.reload
    assert_redirected_to drug_in_drug_movements_url(@drug_in)
    assert_equal 500, @drug_in.cost

    assert_error_div false
  end

  test "should patch update error" do
    patch :update, id: @drug_in,
      drug_in: {
        expired_date: @drug_in.expired_date, 
        cost: "ABC",
        sale_price_per_unit: @drug_in.sale_price_per_unit }

    assert_response :success
    assert_template :edit

    assert_error_div true
  end

  test "should destroy delete" do
    assert_difference 'DrugIn.count', -1 do
      delete :destroy, id: @drug_in
    end

    assert_redirected_to drug_drug_ins_url(@drug_in.drug)
    
    @drug_in.reload
    assert_not_nil @drug_in.deleted_at
    assert @drug_in.deleted?
  end
end