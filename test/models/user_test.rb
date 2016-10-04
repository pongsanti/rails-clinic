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

  test "should verify role operator" do
    @user.roles = [User::ROLES[0]]

    assert @user.operator?
    assert_not @user.doctor?
    assert_not @user.manager?
  end

  test "should verify role doctor" do
    @user.roles = [User::ROLES[1]]

    assert @user.doctor?
    assert_not @user.operator?
    assert_not @user.manager?
  end

  test "should verify role manager" do
    @user.roles = [User::ROLES[2]]

    assert @user.manager?
    assert_not @user.operator?
    assert_not @user.doctor?
  end

  test "should verify role admin" do
    @user.roles = [User::ROLES[3]]

    assert @user.admin?
    assert_not @user.operator?
    assert_not @user.manager?
  end

end
