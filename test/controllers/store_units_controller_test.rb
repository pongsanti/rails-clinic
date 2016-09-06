require 'test_helper'

class StoreUnitsControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @store_unit = store_units(:one)
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_assigns :q, :store_units
  end

  test "should get index with search found" do
    get "index", q: {title_cont: "U"}

    assert_response :success
    assert_assigns :q, :store_units

    assert_equal 1, a(:store_units).count
  end

  test "should get index with search not found" do
    get "index", q: {title_cont: "999"}

    assert_response :success
    assert_assigns :q, :store_units

    assert_equal 0, a(:store_units).count
  end

  test "should get show" do
    get :show, id: @store_unit
    assert_response :success

    assert_assigns :q, :store_unit
    assert_equal @store_unit, a(:store_unit)
  end

  test "should get new" do
    get :new
    assert_response :success

    assert_assigns :q, :store_unit
    assert a(:store_unit).new_record?
  end

  test "should get edit" do
    get :edit, id: @store_unit
    assert_response :success

    assert_assigns :q, :store_unit
    assert_equal @store_unit, a(:store_unit)
  end
  
  test "should post create" do
    assert_difference("StoreUnit.count") do
      post :create, store_unit: { title: @store_unit.title }
    end

    assert_redirected_to store_unit_path(a(:store_unit))
    assert_error_div false
  end

  test "should post create error" do
    assert_no_difference("StoreUnit.count") do
      post :create, store_unit: { title: "" }
    end

    assert_response :success
    assert_assigns :q, :store_unit
    assert_template :new

    assert_error_div true
  end

  test "should patch update" do
    patch :update, id: @store_unit,
      store_unit: {title: "New Unit"}

    @store_unit.reload
    assert_assigns :q, :store_unit
    assert_redirected_to store_unit_path(@store_unit)
    assert_equal "New Unit", @store_unit.title

    assert_error_div false
  end

  test "should patch update error" do
    patch :update, id: @store_unit,
      store_unit: {title: ""}

    assert_assigns :q, :store_unit
    assert_response :success
    assert_template :edit

    assert_error_div true
  end

  test "should delete" do
    delete :destroy, id: @store_unit

    assert_redirected_to store_units_path

    @store_unit.reload
    assert @store_unit.deleted?
    assert_not_nil @store_unit.deleted_at
  end
  
end