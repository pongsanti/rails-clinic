module Admin
  module UsersHelper
    def label_class(user, role)
      ret = "btn btn-default"
      if user.has_role? role
        ret = ret + " active"
      end
      ret
    end
  end
end