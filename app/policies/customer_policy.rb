class CustomerPolicy < ApplicationPolicy
  def show?
    false
  end
end