require 'test_helper'
require "models/common"

class PatientDrugTest < ActiveSupport::TestCase
  include Common
  
  def setup
    @patient_drug = patient_drugs(:one)
    @test_target = @patient_drug
  end

  test "should validate exam" do
    @patient_drug.exam = nil
    assert_not @patient_drug.save
  end

  test "should validate amount" do
    @patient_drug.amount = 20.5
    assert @patient_drug.save
  end

  test "should validate amount error" do
    amount = "activerecord.attributes.patient_drug.amount"

    @patient_drug.amount = nil
    assert_not @patient_drug.save
    error_count 1
    error_contains error_msg(amount, ERR_NOT_A_NUMBER)
  end

  test "should not validate revenue if empty" do
    revenue = "activerecord.attributes.patient_drug.revenue"

    @patient_drug.revenue = nil
    assert @patient_drug.save
  end 

  test "should validate revenue" do
    revenue = "activerecord.attributes.patient_drug.revenue"

    @patient_drug.revenue = "ABC"
    assert_not @patient_drug.save
    error_count 1
    error_contains error_msg(revenue, ERR_NOT_A_NUMBER)
  end

  test "should validate revenue less than zero" do
    revenue = "activerecord.attributes.patient_drug.revenue"

    @patient_drug.revenue = -5.5
    assert_not @patient_drug.save
    error_count 1
    error_contains error_msg(revenue, ERR_GTEQ, count: 0)
  end  
end
