require 'test_helper'

class PrefixTest < ActiveSupport::TestCase

  setup do
    @prefix = prefixes(:mr)
  end

  test "should have customers" do
    assert @prefix.customers
  end
end
