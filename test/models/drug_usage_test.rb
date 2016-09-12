require 'test_helper'
require "models/common"

class DrugUsageTest < ActiveSupport::TestCase
  include Common

  def setup
    @drug_usage = drug_usages(:one)
    @test_target = @drug_usage
  end

  test "should not save without code" do
    code = "activerecord.attributes.drug_usage.code"

    @drug_usage.code = nil
    assert_not @drug_usage.save
    error_count 1
    error_contains error_msg(code, ERR_BLANK)
  end

  test "should not save without text" do
    text = "activerecord.attributes.drug_usage.text"

    @drug_usage.text = nil
    assert_not @drug_usage.save
    error_count 1
    error_contains error_msg(text, ERR_BLANK)
  end

  test "should validate times per day if present" do
    times_per_day = "activerecord.attributes.drug_usage.times_per_day"

    @drug_usage.times_per_day = "ABC"
    assert_not @drug_usage.save
    error_count 1
    error_contains error_msg(times_per_day, ERR_NOT_A_NUMBER)
  end

  test "should validate use amount if present" do
    use_amount = "activerecord.attributes.drug_usage.use_amount"

    @drug_usage.use_amount = "ABC"
    assert_not @drug_usage.save
    error_count 1
    error_contains error_msg(use_amount, ERR_NOT_A_NUMBER)
  end

end
