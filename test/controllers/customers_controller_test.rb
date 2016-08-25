require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  # Including devise test helper
  include Devise::TestHelpers

  setup do
    sign_in users(:john)
    @customer = customers(:customer_david)
    @prefix = prefixes(:mr)
  end

  test "should get index" do
    get "index"

    assert_response :success
    assert_assigns :q, :customers

    assert_not_equal 0, a(:customers).count

    #assert_select "h3 small", I18n.t("customers.index.sub_text")
  end

  test "should get index with search" do
    get "index", q: { name: "name", name_cont: "nobody" }

    assert_response :success
    assert_assigns :q, :customers

    assert_equal 0, a(:customers).count
  end

  test "should get index with search found" do
    get "index", q: { name: "name", name_cont: "David" }

    assert_response :success
    assert_assigns :q, :customers

    assert_equal 1, a(:customers).count    
  end

  test "should get show" do
    get "show", id: @customer.id

    assert_response :success
    assert_assigns :q, :customer
    assert_equal @customer, a(:customer)
  end

  test "should get new" do
    get "new"

    assert_response :success
    assert_assigns :prefixes, :customer, :q
    assert a(:customer).new_record?
  end

  test "should get edit" do
    get "edit", id: @customer.id

    assert_response :success
    assert_assigns :prefixes, :customer
    assert_equal @customer, a(:customer)
  end

  test "should post create" do
    assert_difference "Customer.count" do
      post "create", customer: {prefix_id: @prefix.id, name: "John", surname: "Doe",
        sex: "M", birthdate: "1988-05-05" }
    end

    customer = Customer.last
    assert_redirected_to customer_path(customer)

    assert_equal @prefix, customer.prefix
    assert_equal "John", customer.name

    assert_error_div false
  end

  test "should post create error" do
    assert_no_difference "Customer.count" do
      # prefix is missing
      post "create", customer: {name: "John", surname: "Doe",
        sex: "M", birthdate: "1988-05-05" }
    end

    assert_assigns :q, :customer, :prefixes
    assert_response :success
    assert_template :new

    assert_error_div true
  end

  test "should patch update" do
    patch "update", id: @customer.id,
      customer: {name: "Derek"}

    @customer.reload
    assert_redirected_to customer_path(@customer)
    assert_equal "Derek", @customer.name

    assert_error_div false
  end

  test "should patch update error" do
    #name is empty
    patch "update", id: @customer.id,
      customer: {name: ""}

    assert_assigns :customer, :prefixes, :q
    assert_response :success
    assert_template :edit

    assert_error_div true
  end

  test "should delete" do
    delete "destroy", id: @customer.id

    assert_redirected_to customers_path

    @customer.reload
    assert @customer.deleted?
    assert_not_nil @customer.deleted_at
  end

  private
    def assert_error_div(display)
      assert_select "div#error_explanation", display
    end
end
