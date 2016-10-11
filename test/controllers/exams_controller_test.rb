require 'test_helper'

class ExamsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:david)
    @exam = exams(:exam_one)
    @customer = @exam.customer
    @diag = diags(:two)
    @drug_in = drug_ins(:one)
    @drug_usage = drug_usages(:one)
  end

  test "should route correctly" do
    opts = {controller: "exams"}
    customer_id = "1"
    exam_id = "2"
    #index
    assert_routing route_path(:get, "/customers/1/exams"), opts.merge(action: "index", customer_id: customer_id)
    #show
    assert_routing route_path(:get, "/exams/2"), opts.merge(action: "show", id: exam_id)
    assert_routing route_path(:get, "/exams/2/med"), opts.merge(action: "show_med", id: exam_id)
    assert_routing route_path(:get, "/exam_drug/2"), opts.merge(action: "show_drugs", id: exam_id)
    assert_routing route_path(:get, "/exam_appointment/2"), opts.merge(action: "show_appointments", id: exam_id)
    #new
    assert_routing route_path(:get, "/customers/1/exams/new"), opts.merge(action: "new_weight", customer_id: customer_id)
    #edit
    assert_routing route_path(:get, "/exam_weight/2/edit"), opts.merge(action: "edit_weight", id: exam_id)
    assert_routing route_path(:get, "/exam_pe/2/edit"), opts.merge(action: "edit_pe", id: exam_id)
    assert_routing route_path(:get, "/exam_diag/2/edit"), opts.merge(action: "edit_diag", id: exam_id)
    assert_routing route_path(:get, "/exam_drug/2/edit"), opts.merge(action: "edit_drug", id: exam_id)
    assert_routing route_path(:get, "/exam_revenue/2/edit"), opts.merge(action: "edit_revenue", id: exam_id)
    assert_routing route_path(:get, "/exam_appointment/2/edit"), opts.merge(action: "edit_appointment", id: exam_id)
    #create
    assert_routing route_path(:post, "/customers/1/exams"), opts.merge(action: "create_weight", customer_id: customer_id)
    #update
    assert_routing route_path(:patch, "/exam_weight/2"), opts.merge(action: "update_weight", id: exam_id)
    assert_routing route_path(:patch, "/exam_pe/2"), opts.merge(action: "update_pe", id: exam_id)
    assert_routing route_path(:patch, "/exam_diag/2"), opts.merge(action: "update_diag", id: exam_id)
    assert_routing route_path(:patch, "/exam_drug/2"), opts.merge(action: "update_drug", id: exam_id)
    assert_routing route_path(:patch, "/exam_revenue/2"), opts.merge(action: "update_revenue", id: exam_id)
    assert_routing route_path(:patch, "/exams/2/pay"), opts.merge(action: "pay", id: exam_id)
    assert_routing route_path(:patch, "/exam_appointment/2"), opts.merge(action: "update_appointment", id: exam_id)
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

  test "should get show_med" do
    get :show_med, id: @exam.id

    assert_response :success
    assert_assigns :exam
    assert_equal @exam, a(:exam)
  end

  test "should get show drugs" do
    get :show_drugs, id: @exam.id, format: :pdf

    assert_response :success
    assert_assigns :exam, :customer, :drugs
    assert_equal @exam, a(:exam)
  end

  test "should get show appointments" do
    get :show_appointments, id: @exam.id, format: :pdf

    assert_response :success
    assert_assigns :exam, :customer, :appointments
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

  test "should get edit drug" do
    get :edit_drug, id: @exam.id

    assert_response :success
    assert_assigns :exam, :customer, :drug_ins, :drug_usages
    assert_equal @exam, a(:exam)
    assert_equal @exam.customer, a(:customer)
  end    

  test "should get edit revenue" do
    get :edit_revenue, id: @exam.id

    assert_response :success
    assert_assigns :exam, :customer
    assert_equal @exam, a(:exam)
    assert_equal @exam.customer, a(:customer)
  end

  test "should get edit appointment" do
    get :edit_appointment, id: @exam.id

    assert_response :success
    assert_assigns :exam, :customer
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
    assert_in_delta 100, exam.revenue, 0
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

  test "should patch update revenue" do
    patch :update_revenue, id: @exam.id,
      exam: { revenue: "150" }

    assert_redirected_to exam_url(@exam)
    @exam.reload
    assert_in_delta 150, @exam.revenue, 0
    assert_error_div false
  end

  test "should patch update revenue error" do
    patch :update_revenue, id: @exam.id,
      exam: { revenue: "ABC" }

    assert_response :success
    assert_template "exams/revenue/edit"    
    assert_error_div true
  end  

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

  test "should patch update drug" do
    assert_difference "@exam.patient_drugs.count", 2 do
      patch :update_drug, { id: @exam.id,
        exam: {
          patient_drugs_attributes: {  
            "12556" => { drug_in_id: @drug_in.id, drug_usage_id: @drug_usage.id,
              amount: 10, revenue: 100 },
            "12589" => { drug_in_id: @drug_in.id, drug_usage_id: @drug_usage.id,
              amount: 15, revenue: 200 }
          }
        }
      }
    end

    assert_redirected_to exam_url(@exam)
  end

  test "should patch update drug rejected" do
    assert_no_difference "@exam.patient_drugs.count" do
      patch :update_drug, { id: @exam.id,
        exam: {
          patient_drugs_attributes: {  
            "12556" => { drug_in_id: @drug_in.id, drug_usage_id: @drug_usage.id,
              amount: nil, revenue: nil },
            "12589" => { drug_in_id: @drug_in.id, drug_usage_id: @drug_usage.id,
              amount: nil, revenue: nil }
          }
        }
      }
    end

    assert_redirected_to exam_url(@exam)
  end

  test "should patch update appointment" do
    assert_difference "@exam.appointments.count", 2 do
      patch :update_appointment, { id: @exam.id,
        exam: {
          appointments_attributes: {  
            "12556" => { "date(1i)": 2016, "date(2i)": 11, "date(3i)": 1,
              "time(4i)": 10, "time(5i)": 30, note: "test note" },
            "12589" => { "date(1i)": 2016, "date(2i)": 11, "date(3i)": 15,
              "time(4i)": 10, "time(5i)": 30, note: "test note 2" },
          }
        }
      }
    end

    assert_redirected_to exam_url(@exam)
  end

  test "should patch update appointment rejected" do
    assert_no_difference "@exam.appointments.count" do
      patch :update_appointment, { id: @exam.id,
        exam: {
          appointments_attributes: {  
            "12556" => { "date(1i)": 2016, "date(3i)": 1,
              "time(4i)": 10, "time(5i)": 30, note: "test note" },
            "12589" => { "date(2i)": 11, "date(3i)": 15,
              "time(4i)": 10, "time(5i)": 30, note: "test note 2" },
          }
        }
      }
    end

    assert_redirected_to exam_url(@exam)
  end

  test "should pay" do
    assert_not @exam.paid?

    patch :pay, id: @exam

    assert_redirected_to exam_med_url(@exam)
    assert_assigns :exam, :customer

    @exam.reload
    assert @exam.paid?
  end

  test "should delete destroy" do
    assert_difference "Exam.count", -1 do
      delete :destroy, id: @exam
    end

    assert_redirected_to customer_exams_url(@exam.customer)
    
  end
end