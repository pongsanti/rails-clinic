require 'test_helper'

class DrugMovementsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
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
      get :new
    end
  end

  test "should xhr get new" do
    exam = exams(:exam_one)
    holder = "holder"
    list_holder = "list_holder"

    xhr :get, :new, format: :js, exam_id: exam.id, holder: holder, list_holder: list_holder
    assert_response :success

    assert_not_nil a :drug_movement_amount
    assert_not_nil a :drug_movement
    assert_not_nil a :holder
    assert_not_nil a :list_holder

    assert a(:drug_movement).new_record?
    assert_equal exam.id, a(:drug_movement_amount).exam_id
    assert_equal holder, a(:holder)
    assert_equal list_holder, a(:list_holder)

    assert_select "input[type='hidden'][name='drug_movement_amount[exam_id]']"
    assert_select "input[type='hidden'][name='holder']"

  end  
end