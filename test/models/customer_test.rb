require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  ERR_PREFIX = "errors.messages."
  ERR_BLANK_KEY = ERR_PREFIX + "blank"
  ERR_INCLUSION = ERR_PREFIX + "inclusion"
  ERR_INVALID = ERR_PREFIX + "invalid"

  def setup
    @customer = customers(:customer_david)
  end

  test "should not save without prefix" do
    prefix = "activerecord.attributes.customer.prefix"

    @customer.prefix = nil
    assert_not @customer.save, "Saved the customer without prefix"
    error_count 1
    error_contains error_msg(prefix, ERR_BLANK_KEY)
  end

  test "should not save without sex" do
    sex = "activerecord.attributes.customer.sex"
    msg_blank = error_msg sex, ERR_BLANK_KEY
    msg_inclusion = error_msg sex, ERR_INCLUSION
    
    @customer.sex = nil
    assert_not @customer.save, "Saved the customer without sex"
    error_count 2
    error_contains(msg_blank, msg_inclusion)
  end

  test "should not save without name" do
    name = "activerecord.attributes.customer.name"

    @customer.name = nil
    assert_not @customer.save, "Saved the customer without name"
    error_count 1
    error_contains error_msg(name, ERR_BLANK_KEY)
  end

  test "should not save without surname" do
    surname = "activerecord.attributes.customer.surname"

    @customer.surname = nil
    assert_not @customer.save, "Saved the customer without surname"
    error_count 1
    error_contains error_msg(surname, ERR_BLANK_KEY)
  end

  test "should not save without birthdate" do
    birthdate = "activerecord.attributes.customer.birthdate"

    @customer.birthdate = nil
    assert_not @customer.save, "Saved the customer without birthdate"
    error_count 1
    error_contains error_msg(birthdate, ERR_BLANK_KEY)
  end

  test "should not validate email if empty" do
    @customer.email = nil
    assert @customer.save, "Saved the customer without birthdate"
    error_count 0
  end

  test "should validate email if present" do
    email = "activerecord.attributes.customer.email"

    @customer.email = "wrong email"
    assert_not @customer.save
    error_count 1
    error_contains error_msg(email, ERR_INVALID)
  end

  test "should delete id_card masked input before save" do
    @customer.id_card_no = "1-2345-00007-12-3"
    assert @customer.save
    @customer.reload
    assert_equal "1234500007123", @customer.id_card_no
  end

  test "should delete home_phone masked input before save" do
    @customer.home_phone_no = "0-1234-5678"
    assert @customer.save
    @customer.reload
    assert_equal "012345678", @customer.home_phone_no
  end

  test "should delete tel_no masked input before save" do
    @customer.tel_no = "08-9123-4567"
    assert @customer.save
    @customer.reload
    assert_equal "0891234567", @customer.tel_no
  end    

  test "should have prefix" do
    assert_equal prefixes(:mr).name, @customer.prefix.name
  end

  test "should have exams" do
    assert_equal 2, @customer.exams.count
  end

  private
    def error_count(count)
      assert_equal count, @customer.errors.count
    end

    def error_contains(*msgs)
      found = 0
      msgs.each do |msg|
        found = found + 1 if @customer.errors.full_messages.include? msg
      end
      assert_equal msgs.count, found
    end

    def t(key)
      I18n.t key
    end

    def error_msg(attr_key, error_key)
      "#{t(attr_key)} #{t(error_key)}"
    end

end
