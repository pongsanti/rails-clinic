require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  def setup
    @customer = customers(:customer_david)
  end

  test "should not save without prefix" do
    @customer.prefix = nil
    assert_not @customer.save, "Saved the customer without title"
  end

  test "should not save without sex" do
    @customer.sex = nil
    assert_not @customer.save, "Saved the customer without sex"
  end

  test "should not save without name" do
    @customer.name = nil
    assert_not @customer.save, "Saved the customer without name"
  end

  test "should not save without surname" do
    @customer.surname = nil
    assert_not @customer.save, "Saved the customer without surname"
  end

  test "should not save without birthdate" do
    @customer.birthdate = nil
    assert_not @customer.save, "Saved the customer without birthdate"
  end

  test "should have prefix" do
    assert_equal prefixes(:mr).name, @customer.prefix.name
  end

  test "should have exams" do
    assert_equal 2, @customer.exams.count
  end

end
