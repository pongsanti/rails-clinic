require 'test_helper'

class DrugInTest < ActiveSupport::TestCase
  
  setup do
    @customer = customers(:customer_david)
    @drug_in = drug_ins(:one)
    @exam = exams(:exam_one)
  end

  test "should create drug movement for new drug in" do
    amount = 100
    dmm_count = @drug_in.drug_movements.count

    @drug_in.create_movement_for_new_drug_in(amount)
    @drug_in.save

    assert_equal dmm_count + 1, @drug_in.drug_movements.count
    assert_equal amount, @drug_in.balance

    created = DrugMovement.last
    assert_equal amount, created.balance
    assert_equal 0, created.prev_bal
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
