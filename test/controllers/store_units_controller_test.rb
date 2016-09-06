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

  test "should get new" do
    get :new
    assert_response :success

    assert_assigns :q, :store_unit
    assert a(:store_unit).new_record?
  end
=begin
  test "should create store_unit" do
    assert_difference('StoreUnit.count') do
      post :create, store_unit: { title: @store_unit.title }
    end

    assert_redirected_to store_unit_path(assigns(:store_unit))
  end

  test "should show store_unit" do
    get :show, id: @store_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store_unit
    assert_response :success
  end

  test "should update store_unit" do
    patch :update, id: @store_unit, store_unit: { title: @store_unit.title }
    assert_redirected_to store_unit_path(assigns(:store_unit))
  end

  test "should destroy store_unit" do
    assert_difference('StoreUnit.count', -1) do
      delete :destroy, id: @store_unit
    end

    assert_redirected_to store_units_path
  end
=end  
end
