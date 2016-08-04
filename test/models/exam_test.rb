require 'test_helper'
require 'models/common'

class ExamTest < ActiveSupport::TestCase
  include Common

  def setup
    @exam = exams(:exam_one)
    @test_target = @exam
  end

  test "should not validate weight if empty" do
    @exam.weight = nil
    assert @exam.save
    error_count 0
  end

  test "should validate weight if present" do
    weight = "activerecord.attributes.exam.weight"

    @exam.weight = 1000
    assert_not @exam.save
    error_count 1
    error_contains error_msg(weight, ERR_INVALID)
  end

  test "should not validate height if empty" do
    @exam.height = nil
    assert @exam.save
    error_count 0
  end

  test "should validate height if present" do
    height = "activerecord.attributes.exam.height"

    @exam.height = 1000
    assert_not @exam.save
    error_count 1
    error_contains error_msg(height, ERR_INVALID)
  end

  test "should not validate pulse if empty" do
    @exam.pulse = nil
    assert @exam.save
    error_count 0
  end

  test "should validate pulse if present" do
    pulse = "activerecord.attributes.exam.pulse"

    @exam.pulse = 1000
    assert_not @exam.save
    error_count 1
    error_contains error_msg(pulse, ERR_INVALID)
  end

  test "should not validate bp_systolic if empty" do
    @exam.bp_systolic = nil
    assert @exam.save
    error_count 0
  end

  test "should validate bp_systolic if present" do
    bp_systolic = "activerecord.attributes.exam.bp_systolic"

    @exam.bp_systolic = 1000
    assert_not @exam.save
    error_count 1
    error_contains error_msg(bp_systolic, ERR_INVALID)
  end

  test "should not validate bp_diastolic if empty" do
    @exam.bp_diastolic = nil
    assert @exam.save
    error_count 0
  end

  test "should validate bp_diastolic if present" do
    bp_diastolic = "activerecord.attributes.exam.bp_diastolic"

    @exam.bp_diastolic = 1000
    assert_not @exam.save
    error_count 1
    error_contains error_msg(bp_diastolic, ERR_INVALID)
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

end