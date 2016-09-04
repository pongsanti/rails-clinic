require 'test_helper'

class ExamsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @exam = exams(:exam_one)
    @customer = @exam.customer
    @diag = diags(:two)
  end

  test "should route correctly" do
    opts = {controller: "exams"}
    customer_id = "1"
    exam_id = "2"
    #index
    assert_routing route_path(:get, "/customers/1/exams"), opts.merge(action: "index", customer_id: customer_id)
    #show
    assert_routing route_path(:get, "/exams/2"), opts.merge(action: "show", id: exam_id)
    #new
    assert_routing route_path(:get, "/customers/1/exams/new"), opts.merge(action: "new_weight", customer_id: customer_id)
    #edit
    assert_routing route_path(:get, "/exam_weight/2/edit"), opts.merge(action: "edit_weight", id: exam_id)
    assert_routing route_path(:get, "/exam_pe/2/edit"), opts.merge(action: "edit_pe", id: exam_id)
    assert_routing route_path(:get, "/exam_diag/2/edit"), opts.merge(action: "edit_diag", id: exam_id)
    #create
    assert_routing route_path(:post, "/customers/1/exams"), opts.merge(action: "create_weight", customer_id: customer_id)
    #update
    assert_routing route_path(:patch, "/exam_weight/2"), opts.merge(action: "update_weight", id: exam_id)
    assert_routing route_path(:patch, "/exam_pe/2"), opts.merge(action: "update_pe", id: exam_id)
    assert_routing route_path(:patch, "/exam_diag/2"), opts.merge(action: "update_diag", id: exam_id)
    #destroy
    assert_routing route_path(:delete, "/exams/2"), opts.merge(action: "destroy", id: exam_id)
  end

  test "should get index" do
    get :index, customer_id: @customer.id
    assert_response :success

    assert_assigns :q, :exams, :customer
    assert_equal @customer, a(:customer)
  end

  test "should get show" do
    get :show, id: @exam.id

    assert_response :success
    assert_assigns :exam
    assert_equal @exam, a(:exam)
  end

  test "should get new weight" do
    get :new_weight, customer_id: @customer.id
    assert_response :success

    assert_assigns :exam, :customer
    assert_equal @customer, a(:customer)
    assert a(:exam).new_record?
  end

  test "should get edit weight" do
    get :edit_weight, id: @exam.id

    assert_response :success
    assert_assigns :exam, :customer
    assert_equal @exam, a(:exam)
    assert_equal @exam.customer, a(:customer)
  end

  test "should get edit pe" do
    get :edit_pe, id: @exam.id

    assert_response :success
    assert_assigns :exam, :customer
    assert_equal @exam, a(:exam)
    assert_equal @exam.customer, a(:customer)
  end

  test "should get edit diag" do
    get :edit_diag, id: @exam.id

    assert_response :success
    assert_assigns :exam, :customer, :diags
    assert_equal @exam, a(:exam)
    assert_equal @exam.customer, a(:customer)
  end  

  test "should post create weight" do
    assert_difference "Exam.count", 1 do
      post :create_weight, customer_id: @customer.id,
        exam: { weight: 75, height: 125, bp_systolic: 120, bp_diastolic: 80, pulse: 75, note: "cold"}
    end

    exam = Exam.last
    assert_redirected_to exam_url(exam)
  end

  test "should post create weight error" do
    assert_no_difference "Exam.count" do
      post :create_weight, customer_id: @customer.id,
        exam: { weight: "ABC", height: 125, bp_systolic: 120, bp_diastolic: 80, pulse: 75, note: "cold"}
    end

    assert_response :success
    assert_template "new_weight"
    assert_assigns :customer
    assert_error_div true
  end  

  test "should patch update weight" do
    patch :update_weight, { id: @exam.id,
      exam: { weight: 100, height: 100 } }

    assert_redirected_to exam_url(@exam)
    @exam.reload
    assert_in_delta 100, @exam.weight, 0
    assert_in_delta 100, @exam.height, 0
  end

  test "should patch update weight error" do
    patch :update_weight, { id: @exam.id,
      exam: { weight: "ABC", height: 100 } }

    assert_response :success
    assert_template "edit_weight"
    assert_assigns :customer
    assert_error_div true
  end

  test "should patch update pe" do
    patch :update_pe, { id: @exam.id,
      exam: { exam_pi: "Update PI", exam_pe: "Update PE" } }

    assert_redirected_to exam_url(@exam)
    @exam.reload
    assert_equal "Update PI", @exam.exam_pi
    assert_equal "Update PE", @exam.exam_pe
  end
=begin
  test "should patch update pe error" do
    patch :update_pe, { id: @exam.id }

    assert_response :success
    assert_template "edit_pe"
    assert_assigns :customer
    assert_error_div true
  end  
=end
  test "should patch update diag" do
    assert_difference "@exam.diags.count", 2 do
      patch :update_diag, { id: @exam.id,
        exam: {
          patient_diags_attributes: {  
            "12556" => { diag_id: @diag.id, note: "note01" },
            "12589" => { diag_id: @diag.id, note: "note02" }
          }
        }
      }
    end

    assert_redirected_to exam_url(@exam)
  end

  private
    def route_path(method, path)
      {method: method, path: path}
    end
end