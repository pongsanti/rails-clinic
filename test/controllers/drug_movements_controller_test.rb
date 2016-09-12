require 'test_helper'

class DrugMovementsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @drug_movement = drug_movements(:one)
    @drug_in = drug_ins(:one)
  end

  test "should route correctly" do
    opts = {controller: "drug_movements"}
    drug_in_id = "1"
    drug_movement_id = "2"
    #index
    assert_routing route_path(:get, "/drug_ins/1/drug_movements"), opts.merge(action: "index", drug_in_id: drug_in_id)
    #show
    assert_routing route_path(:get, "/drug_movements/2"), opts.merge(action: "show", id: drug_movement_id )
    #new
    assert_routing route_path(:get, "/drug_ins/1/drug_movements/new"), opts.merge(action: "new", drug_in_id: drug_in_id)
    #create
    assert_routing route_path(:post, "/drug_ins/1/drug_movements"), opts.merge(action: "create", drug_in_id: drug_in_id)
  end

  test "should get index" do
    get "index", drug_in_id: @drug_in

    assert_response :success
    assert_assigns :q, :drug_in, :drug, :drug_movements
  end

  test "should get show" do
    get "show", id: @drug_movement

    assert_response :success
    assert_assigns :drug_in, :drug, :drug_movement
  end

  test "should get new" do
    get "new", drug_in_id: @drug_in

    assert_response :success
    assert_assigns :drug_in, :drug, :drug_movement
    assert a(:drug_movement).new_record?
  end

  test "should post create" do
    amount = 100
    drug_in_balance = @drug_in.balance
    drug_balance = @drug_in.drug.balance

    assert_difference "DrugMovement.count" do
      post "create", drug_in_id: @drug_in,
        drug_movement: {
          amount: amount,
          note: "note" }
    end

    assert_redirected_to drug_in_drug_movements_url(@drug_in)
    drug_movement = DrugMovement.last

    assert_equal drug_in_balance + amount, drug_movement.drug_in.balance
    assert_equal drug_balance + amount, drug_movement.drug.balance

    assert_error_div false
  end

  test "should post create error" do
    post "create", drug_in_id: @drug_in,
      drug_movement: {
        amount: "ABC"
      }

    assert_response :success
    assert_template :new

    assert_error_div true
  end
end