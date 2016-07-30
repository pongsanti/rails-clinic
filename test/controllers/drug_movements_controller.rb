require 'test_helper'

class DrugMovementsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
  end

  test "should get index" do
    sign_in users(:john)

    assert_raises ActionView::MissingTemplate do
      get :index
    end
    #assert_response 
  end

  test "should get show" do
    sign_in users(:john)

    assert_raises ActionView::MissingTemplate do
      get :show, id: 1
    end
  end

  test "should get new" do
    sign_in users(:john)

    assert_raises ActionView::MissingTemplate do
      get :new
    end
  end

  test "should xhr get new" do
    sign_in users(:john)

    exam = exams(:exam_one)

    xhr :get, :new, format: :js, exam_id: exam.id
    assert_response :success

    assert_not_nil assigns :drug_movement
    assert_not_nil assigns :exam_id

    assert assigns(:drug_movement).new_record?
    assert_equal exam.id, assigns(:exam_id)
  end  
end