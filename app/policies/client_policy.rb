class ClientPolicy < ApplicationPolicy

  #edit
  def edit_settings?
    manager_or_higher?
  end
  
end