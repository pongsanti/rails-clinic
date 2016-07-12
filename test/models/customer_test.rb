require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  def setup
    @customer = customers(:customer_david)
  end

  test "should not save without prefix" do
    prefix_locale = I18n.t "activerecord.attributes.customer.prefix"

    @customer.prefix = nil
    assert_not @customer.save, "Saved the customer without prefix"
    assert_equal 1, @customer.errors.count
    assert @customer.errors.full_messages[0].include? prefix_locale
  end

  test "should not save without sex" do
    sex_locale = I18n.t "activerecord.attributes.customer.sex"
    
    @customer.sex = nil
    assert_not @customer.save, "Saved the customer without sex"
    assert_equal 2, @customer.errors.count
    @customer.errors.full_messages.each do |msg|
      assert msg.include? sex_locale
    end
  end

  test "should not save without name" do
    name_locale = I18n.t "activerecord.attributes.customer.name"

    @customer.name = nil
    assert_not @customer.save, "Saved the customer without name"
    assert_equal 1, @customer.errors.count
    assert @customer.errors.full_messages[0].include? name_locale
  end

  test "should not save without surname" do
    surname_locale = I18n.t "activerecord.attributes.customer.surname"

    @customer.surname = nil
    assert_not @customer.save, "Saved the customer without surname"
    assert 1 == @customer.errors.count
    assert @customer.errors.full_messages[0].include? surname_locale
  end

  test "should not save without birthdate" do
    birthdate_locale = I18n.t "activerecord.attributes.customer.birthdate"

    @customer.birthdate = nil
    assert_not @customer.save, "Saved the customer without birthdate"
    assert 1 == @customer.errors.count
    assert @customer.errors.full_messages[0].include? birthdate_locale
  end

  test "should have prefix" do
    assert_equal prefixes(:mr).name, @customer.prefix.name
  end

  test "should have exams" do
    assert_equal 2, @customer.exams.count
  end

end
