require 'test_helper'
require 'models/common'

class AppointmentTest < ActiveSupport::TestCase
  include Common

  def setup
    @appointment = appointments(:one)
    @test_target = @appointment
  end

  test "should validate date" do
    date = "activerecord.attributes.appointment.date"

    @appointment.date = nil
    assert_not @appointment.save
    error_count 1
    error_contains error_msg(date, ERR_BLANK)
  end

  test "should validate exam" do
    exam = "activerecord.attributes.appointment.exam"

    @appointment.exam = nil
    assert_not @appointment.save
    error_count 1
    error_contains error_msg(exam, ERR_BLANK)    
  end
end
