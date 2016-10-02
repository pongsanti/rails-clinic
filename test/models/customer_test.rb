require 'test_helper'
require 'models/common'

class CustomerTest < ActiveSupport::TestCase
  include Common

  def setup
    @customer = customers(:customer_david)
    @test_target = @customer
  end

  test "should not save without prefix" do
    prefix = "activerecord.attributes.customer.prefix"

    @customer.prefix = nil
    assert_not @customer.save, "Saved the customer without prefix"
    error_count 1
    error_contains error_msg(prefix, ERR_BLANK)
  end

  test "should not save with duplicated cn" do
    cn = "activerecord.attributes.customer.cn"

    john = customers(:customer_two)
    @customer.cn = john.cn
        
    assert_not @customer.save
    error_count 1
    error_contains error_msg(cn, ERR_TAKEN)
  end

  test "should not save without sex" do
    sex = "activerecord.attributes.customer.sex"
    msg_blank = error_msg sex, ERR_BLANK
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
    error_contains error_msg(name, ERR_BLANK)
  end

  test "should not save without surname" do
    surname = "activerecord.attributes.customer.surname"

    @customer.surname = nil
    assert_not @customer.save, "Saved the customer without surname"
    error_count 1
    error_contains error_msg(surname, ERR_BLANK)
  end

  test "should not save without birthdate" do
    birthdate = "activerecord.attributes.customer.birthdate"

    @customer.birthdate = nil
    assert_not @customer.save, "Saved the customer without birthdate"
    error_count 1
    error_contains error_msg(birthdate, ERR_BLANK)
  end

  test "should not validate email if empty" do
    should_not_validate_if_empty :email
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

  test "should get latest cn" do
    john = customers(:customer_two)
    cn = john.cn
    prefix = cn_prefix
    if prefix == "#{cn[0]}#{cn[1]}".to_i
      assert_equal (cn.to_i + 1).to_s, Customer.latest_cn
    else
      assert_equal "#{prefix}00000", Customer.latest_cn
    end
  end

  test "should get latest cn case first record" do
    john = customers(:customer_two)
    john.cn = "0000"
    john.save
    @customer.cn = "0001"
    @customer.save
    
    prefix = cn_prefix
    assert_equal "#{prefix}00000", Customer.latest_cn
  end

  private
    def cn_prefix
      (Date.current.year + 543) % 100
    end

end