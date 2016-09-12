require 'test_helper'
require "models/common"

class QTest < ActiveSupport::TestCase
  include Common

  setup do
    @q = qs(:one)
    @test_target = @q
  end

  test "should validate category if present" do
    @q.category = "C"
    assert_not @q.save
    error_count 1
  end

  test "should validate exam" do
    @q.exam = nil
    assert_not @q.save
    error_count 1
  end  

  test "should scope by category" do
    assert_equal 2, Q.cat_is("B").count
    assert_equal 1, Q.cat_is("A").count
  end

end
