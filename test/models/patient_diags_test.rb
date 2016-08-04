require 'test_helper'

class PatientDiagsTest < ActiveSupport::TestCase

  setup do
    @patient_diag = patient_diags(:one)
  end

  test "should belong to an exam" do
    assert @patient_diag.exam
  end

  test "should belong to a diag" do
    assert @patient_diag.diag
  end
end