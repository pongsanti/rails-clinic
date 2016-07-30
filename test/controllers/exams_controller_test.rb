require 'test_helper'

class ExamsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @customer = customers(:customer_david)
    @exam = exams(:exam_one)
  end

  test "should get index" do
    get :index, customer_id: @customer.id
    assert_response :success

    assert_customer

    assert_not_nil a(:q)
    assert_not_nil a(:exams)
  end

  test "should get show" do
    get :show, id: @exam.id

    assert_response :success
    assert_not_nil a(:exam)

    assert_equal @exam, a(:exam)
  end

  test "should get new" do
    get :new, customer_id: @customer.id
    assert_response :success

    assert_customer

    assert_not_nil a(:exam)
    assert a(:exam).new_record?
  end

  test "should get edit" do
    get :edit, id: @exam.id

    assert_response :success
    assert_not_nil a(:exam)
    assert_equal @exam, a(:exam)
  end

  test "should post create" do
    post :create, customer_id: @customer.id, submit: "submit",
      exam: { weight: 75, height: 125, bp_systolic: 120, bp_diastolic: 80, pulse: 75, drug_allergy: "paracet", note: "cold"}

    exam = Exam.last
    assert_redirected_to exam_url(exam)
  end

  test "should post create and stay same page" do
    post :create, customer_id: @customer.id,
      exam: { weight: 75, height: 125, bp_systolic: 120, bp_diastolic: 80, pulse: 75, drug_allergy: "paracet", note: "cold"}

    exam = Exam.last
    assert_redirected_to edit_exam_url(exam)
  end

  test "should put update" do
    put :update, update_params.merge(id: @exam.id)

    assert_update
    assert_redirected_to exam_url(@exam)
  end

  test "should put update and stay same page" do
    put :update, update_params.merge(id: @exam.id, submit_and_stay: "submit_and_stay")

    assert_update
    assert_response :success
  end  

  private
    def assert_customer
      assert_not_nil a(:customer)
      assert_equal @customer, a(:customer)
    end

    def update_params
      { exam: { weight: 75, height: 125 } }
    end

    def assert_update
      @exam = Exam.find(@exam.id)
      assert_in_delta 75, @exam.weight, 0
      assert_in_delta 125, @exam.height, 0
    end
end