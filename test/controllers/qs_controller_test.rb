require 'test_helper'

class QsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @q = qs(:one)
    @exam = exams(:exam_one)
  end

  test "should route correctly" do
    opts = {controller: "qs"}
    q_id = "1"
    exam_id = "2"
    #index
    assert_routing route_path(:get, "/qs"), opts.merge(action: "index")
    #create
    assert_routing route_path(:post, "/exams/2/qs"), opts.merge(action: "create", exam_id: exam_id)
    #destroy
    assert_routing route_path(:delete, "/qs/1"), opts.merge(action: "destroy", id: q_id)
    #switch_category
    assert_routing route_path(:patch, "/qs/1/switch"), opts.merge(action: "switch_category", id: q_id)
    #activate
    assert_routing route_path(:patch, "/qs/1/activate"), opts.merge(action: "activate", id: q_id)
  end

  test "should xhr get index" do
    xhr :get, "index"

    assert_response :success
    assert_assigns :exQs, :medQs
    assert_equal 2, a(:exQs).count
    assert_equal 2, a(:medQs).count
  end

  test "should xhr post create" do
    assert_difference "Q.count", 1 do
      xhr :post, "create", exam_id: @exam.id
    end

    assert_response :success
  end

  test "should xhr patch switch category" do
    assert_equal Q::EXAM_Q_CAT, @q.category

    xhr :patch, "switch_category", id: @q.id

    assert_response :success

    @q.reload
    assert_equal Q::MED_Q_CAT, @q.category
  end

  test "should patch activate" do
    patch :activate, id: @q.id

    assert_redirected_to exam_url(@exam)
    
    @q.reload
    assert @q.active
    assert_equal 1, Q.cat_is(@q.category).where('active = ?', true).count
  end

  test "should patch activate and redirect correctly" do
    @q = qs(:three)

    patch :activate, id: @q.id

    assert_redirected_to exam_med_url(@q.exam)    
  end  

  test "should xhr delete destroy" do
    assert_difference "Q.count", -1 do
      xhr :delete, "destroy", id: @q.id
    end

    assert_response :success
  end

end