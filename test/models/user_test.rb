require 'test_helper'
require 'models/common'

class UserTest < ActiveSupport::TestCase
  include Common
  
  def setup
    @user = users(:david)
    @test_target = @user
  end

  test "should has 4 roles" do
    assert 4, User::ROLES.count
  end

  test "should set role" do
    role = User::ROLES[0]
    @user.roles = [role]

    assert_equal role, @user.roles[0]
    assert @user.has_role? role
  end

  test "should set roles" do
    roles = [User::ROLES[0], User::ROLES[3]]
    @user.roles = roles

    roles.each do |r|
      assert @user.roles.include? r
      assert @user.has_role? r
    end
  end

end
