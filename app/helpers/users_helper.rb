module UsersHelper

  def role_icon_class(bool)
    if bool
      "glyphicon glyphicon-ok"
    else
      "glyphicon glyphicon-minus"
    end   

  end

  def display_name(user)
    user.display_name.blank? ? "N/A" : user.display_name
  end

  def label_class(user, role)
    ret = "btn btn-default"
    if user.has_role? role
      ret = ret + " active"
    end
    ret
  end
  
end
