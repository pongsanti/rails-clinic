ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def a(key)
    assigns(key)
  end

  def assert_assigns(*symbols)
    symbols.each do |obj|
      assert_not_nil a(obj)
    end
  end

  def assert_error_div(display)
    assert_select "div#error_explanation", display
  end

  def route_path(method, path)
    {method: method, path: path}
  end
end
