class UserPolicy < ApplicationPolicy

  def index?
    manager_or_higher?
  end

  def edit?
    manager_or_higher?
  end

  def update?
    manager_or_higher?
  end

end