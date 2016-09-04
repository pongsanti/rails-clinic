require 'test_helper'

class QTest < ActiveSupport::TestCase

  test "should scope by category" do
    assert_equal 2, Q.cat_is("W").count
    assert_equal 1, Q.cat_is("C").count
  end

end
