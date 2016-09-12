require 'test_helper'
require "models/common"

class StoreUnitTest < ActiveSupport::TestCase
  include Common

  def setup
    @store_unit = store_units(:one)
    @test_target = @store_unit
  end

  test "should not save without title" do
    title = "activerecord.attributes.store_unit.title"

    @store_unit.title = nil
    assert_not @store_unit.save
    error_count 1
    error_contains error_msg(title, ERR_BLANK)
  end

end
