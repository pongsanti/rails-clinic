require 'test_helper'
require 'models/common'

class ExamTest < ActiveSupport::TestCase
  include Common

  def setup
    @exam = exams(:exam_one)
    @test_target = @exam
  end

  test "should not validate weight if empty" do
    should_not_validate_if_empty :weight
  end

  test "should validate weight if present" do
    weight = "activerecord.attributes.exam.weight"

    @exam.weight = 1000
    assert_not @exam.save
    error_count 2
    error_contains error_msg(weight, ERR_INVALID), error_msg(weight, ERR_LESS_THAN, count: 500)
  end

  test "should validate weight value as string" do
    weight = "activerecord.attributes.exam.weight"

    @exam.weight = "ABC"
    assert_not @exam.save
    error_count 1
    error_contains error_msg(weight, ERR_NOT_A_NUMBER)
  end

  test "should not validate height if empty" do
    should_not_validate_if_empty :height
  end

  test "should validate height if present" do
    height = "activerecord.attributes.exam.height"

    @exam.height = 1000
    assert_not @exam.save
    error_count 2
    error_contains(error_msg(height, ERR_INVALID), error_msg(height, ERR_LESS_THAN, count: 500))
  end

  test "should not validate pulse if empty" do
    should_not_validate_if_empty :pulse
  end

  test "should validate pulse if present" do
    pulse = "activerecord.attributes.exam.pulse"

    @exam.pulse = 1000
    assert_not @exam.save
    error_count 2
    error_contains error_msg(pulse, ERR_INVALID), error_msg(pulse, ERR_LESS_THAN, count: 300)
  end

  test "should not validate bp_systolic if empty" do
    should_not_validate_if_empty :bp_systolic
  end

  test "should validate bp_systolic if present" do
    bp_systolic = "activerecord.attributes.exam.bp_systolic"

    @exam.bp_systolic = 1000
    assert_not @exam.save
    error_count 2
    error_contains error_msg(bp_systolic, ERR_INVALID), error_msg(bp_systolic, ERR_LESS_THAN, count: 300)
  end

  test "should not validate bp_diastolic if empty" do
    should_not_validate_if_empty :bp_diastolic
  end

  test "should validate bp_diastolic if present" do
    bp_diastolic = "activerecord.attributes.exam.bp_diastolic"

    @exam.bp_diastolic = 1000
    assert_not @exam.save
    error_count 2
    error_contains error_msg(bp_diastolic, ERR_INVALID), error_msg(bp_diastolic, ERR_LESS_THAN, count: 300)
  end

  test "should validate revenue if present" do
    revenue = "activerecord.attributes.exam.revenue"

    @exam.revenue = "ABC"
    assert_not @exam.save
    error_count 1
    error_contains error_msg(revenue, ERR_NOT_A_NUMBER)
  end

  test "should validate customer" do
    @exam.customer = nil
    assert_not @exam.save
    error_count 1
  end

  test "should belong to a customer" do
    assert @exam.customer
  end

  test "should belong to an examiner" do
    assert @exam.examiner
  end

  test "should not belong to a drug" do
    assert_raise NoMethodError do
      @exam.drug
    end
  end

  test "should have patient_diags" do
    assert @exam.patient_diags
  end

  test "should have diags" do
    assert @exam.diags
  end

  test "should not calculate bmi" do
    @exam.weight = nil
    assert_equal "N/A", @exam.bmi
  end

  test "should calculate bmi" do
    @exam.weight = 75
    @exam.height = 175
    assert_in_delta 24.5, @exam.bmi, 0
  end

end