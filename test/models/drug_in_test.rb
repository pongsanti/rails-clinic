require 'test_helper'
require "models/common"

class DrugInTest < ActiveSupport::TestCase
    include Common
  
  setup do
    @customer = customers(:customer_david)
    @drug_in = drug_ins(:one)
    @exam = exams(:exam_one)
    @test_target = @drug_in
  end

  test "should validate drug" do
    drug = "activerecord.attributes.drug_in.drug"

    @drug_in.drug = nil
    @drug_in.amount = 100
    assert_not @drug_in.save
    error_count 1
    error_contains error_msg(drug, ERR_BLANK)
  end

  test "should validate amount" do
    amount = "activerecord.attributes.drug_in.amount"

    @drug_in.amount = nil
    assert_not @drug_in.save
    error_count 2
    error_contains error_msg(amount, ERR_BLANK), error_msg(amount, ERR_NOT_A_NUMBER)
  end

  test "should validate cost if present" do
    cost = "activerecord.attributes.drug_in.cost"

    @drug_in.amount = 100
    @drug_in.cost = "ABC"
    assert_not @drug_in.save
    error_count 1
    error_contains error_msg(cost, ERR_NOT_A_NUMBER)
  end

  test "should validate sale_price_per_unit if present" do
    sale_price_per_unit = "activerecord.attributes.drug_in.sale_price_per_unit"

    @drug_in.amount = 100
    @drug_in.sale_price_per_unit = "ABC"
    assert_not @drug_in.save
    error_count 1
    error_contains error_msg(sale_price_per_unit, ERR_NOT_A_NUMBER)
  end  

  test "should create drug movement for new drug in" do
    drug_in = DrugIn.new(amount: 100, drug_id: @drug_in.drug)
    assert 0, drug_in.drug_movements.count

    drug_in.create_movement_for_new_drug_in
    drug_in.save
    assert 1,  drug_in.drug_movements.count

    assert_equal 100, drug_in.balance

    dmm = drug_in.drug_movements.last
    assert_equal 100, dmm.balance
    assert_equal 0, dmm.prev_bal
  end

  test "should create drug movement for drug out" do
    # pre-condition balance should equal in both
    latest_bal = @drug_in.drug_movements.last.balance
    assert_equal @drug_in.balance, latest_bal

    amount = 5
    dmm_count = @drug_in.drug_movements.count

    drug_movement = DrugMovement.new({amount: amount, drug_in_id: @drug_in.id, exam_id: @exam.id})
    @drug_in.create_movement_for_drug_out(drug_movement)
    #drug_movement.save
    @drug_in.save

    assert_equal dmm_count + 1, @drug_in.drug_movements.count
    assert_equal latest_bal - amount, @drug_in.balance
    
    created = DrugMovement.last
    assert_equal latest_bal, created.prev_bal
    assert_equal latest_bal - amount, created.balance
    assert_equal @exam, created.exam
  end

end
