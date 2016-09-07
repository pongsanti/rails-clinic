require 'test_helper'
require "models/common"

class DrugTest < ActiveSupport::TestCase
  include Common

  def setup
    @drug = drugs(:one)
    @test_target = @drug
  end

  test "should not save without name" do
    name = "activerecord.attributes.drug.name"

    @drug.name = nil
    assert_not @drug.save
    error_count 1
    error_contains error_msg(name, ERR_BLANK)
  end
end
