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

end
