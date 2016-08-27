require 'test_helper'
require 'models/common'

class DiagTest < ActiveSupport::TestCase
  include Common

  def setup
    @diag = diags(:one)
    @test_target = @diag
  end

  test "should has patient_diags" do
    assert_not_nil @diag.patient_diags
  end

  test "should has exams" do
    assert_not_nil @diag.exams
  end

  test "should not save without name" do
    name = "activerecord.attributes.diag.name"

    @diag.name = nil
    assert_not @diag.save

    error_count 1
    error_contains error_msg(name, ERR_BLANK)
  end
end
