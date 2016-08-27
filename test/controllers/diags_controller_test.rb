require 'test_helper'

class DiagsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @diag = diags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success

    assert_assigns :q, :diags
  end

  test "should get index with search" do
    get "index", q: {name_or_description_cont: "Diags02" }
    assert_response :success

    assert_assigns :q, :diags
    assert_equal 1, a(:diags).count
  end

  test "should get index with search not found" do
    get "index", q: {name_or_description_cont: "xxx" }
    assert_response :success

    assert_assigns :q, :diags
    assert_equal 0, a(:diags).count
  end

  test "should get show" do
    get :show, id: @diag
    assert_response :success

    assert_assigns :q, :diag
    assert_equal @diag, a(:diag)
  end

  test "should get new" do
    get :new
    assert_response :success

    assert_assigns :q, :diag
    assert a(:diag).new_record?
  end

  test "should get edit" do
    get :edit, id: @diag
    assert_response :success

    assert_assigns :q, :diag
    assert_equal @diag, a(:diag)
  end

  test "should post create" do
    assert_difference('Diag.count') do
      post :create, diag: { description: @diag.description, name: @diag.name }
    end

    assert_assigns :q, :diag
    assert_redirected_to diag_path(a(:diag))
    assert_error_div false
  end

  test "should post create validate not pass" do
    assert_no_difference("Diag.count") do
      post :create, diag: { description: @diag.description, name: "" }
    end
    
    assert_assigns :q, :diag
    assert_response :success
    assert_template :new

    assert_error_div true
  end

  test "should patch upate" do
    patch :update, id: @diag, diag: { description: @diag.description, name: @diag.name }
    
    assert_assigns :q, :diag
    assert_redirected_to diag_path(a(:diag))
    assert_error_div false
  end

  test "should patch upate error" do
    patch :update, id: @diag, diag: { description: @diag.description, name: "" }
    
    assert_assigns :q, :diag
    assert_response :success
    assert_template :edit
    assert_error_div true
  end

  test "should delete destroy" do
    delete :destroy, id: @diag

    assert_redirected_to diags_path

    @diag.reload
    assert @diag.deleted?
    assert_not_nil @diag.deleted_at
  end
end
