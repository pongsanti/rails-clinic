require 'test_helper'
require "models/common"

class DrugMovementTest < ActiveSupport::TestCase
  include Common

  setup do
    @drug_movement = drug_movements(:one)
    @drug_movement.amount = 100

    @exam = exams(:exam_one)
    @test_target = @drug_movement
  end

  test "should validate amount" do
    amount = "activerecord.attributes.drug_movement.amount"

    @drug_movement.amount = "ABC"
    assert_not @drug_movement.save
    error_count 1
    error_contains error_msg(amount, ERR_NOT_A_NUMBER)
  end

  test "should validate drug_in" do
    drug_in = "activerecord.attributes.drug_movement.drug_in"

    @drug_movement.drug_in = nil
    assert_not @drug_movement.save
    error_count 1
    error_contains error_msg(drug_in, ERR_BLANK)
  end

end