module UsersHelper
  def role_icon_class(bool)
    if bool
      "glyphicon glyphicon-ok"
    else
      "glyphicon glyphicon-minus"
    end   
  end
end
