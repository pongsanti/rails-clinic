require 'test_helper'

class DrugMovementsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @exam = exams(:exam_one)
    @drug_in = drug_ins(:one)

    @holder = "holder"
    @list_holder = "list_holder"
  end

  test "should get index" do

    assert_raises ActionView::MissingTemplate do
      get :index
    end
    #assert_response 
  end

  test "should get show" do
    assert_raises ActionView::MissingTemplate do
      get :show, id: 1
    end
  end

  test "should get new" do
    assert_raises ActionView::MissingTemplate do
      get :new, drug_movement: { note: "" }
    end
  end

  test "should xhr get new" do

    xhr :get, :new, format: :js, holder: @holder, list_holder: @list_holder,
      drug_movement: {exam_id: @exam.id}
    assert_response :success

    assert_not_nil a :drug_movement
    assert_not_nil a :holder
    assert_not_nil a :list_holder

    assert a(:drug_movement).new_record?
    assert_equal @exam.id, a(:drug_movement).exam_id
    assert_equal @holder, a(:holder)
    assert_equal @list_holder, a(:list_holder)
  end

  test "should xhr post create" do
    dmm_count = @drug_in.drug_movements.count
    di_balance = @drug_in.balance
    d_balance = @drug_in.drug.balance
    amount = 5

    xhr :post, :create, format: :js, holder: @holder, list_holder: @list_holder,
      drug_movement: {exam_id: @exam.id, amount: amount, drug_in_id: @drug_in.id , note: "note"}
    assert_response :success

    @drug_in.reload
    #drug_in balance
    assert_equal dmm_count + 1, @drug_in.drug_movements.count
    assert_equal di_balance - amount, @drug_in.balance

    #drug_movement
    dmm = @drug_in.drug_movements.last
    assert_equal di_balance, dmm.prev_bal
    assert_equal di_balance - amount, dmm.balance

    #drug balance
    d = @drug_in.drug
    assert_equal d_balance - amount, d.balance
  end
end