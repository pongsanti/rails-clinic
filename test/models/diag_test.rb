require 'test_helper'

class DiagTest < ActiveSupport::TestCase

  def setup
    @diag = diags(:one)
  end

  test "should has patient_diags" do
    assert_not_nil @diag.patient_diags
  end

  test "should has exams" do
    assert_not_nil @diag.exams
  end
end
