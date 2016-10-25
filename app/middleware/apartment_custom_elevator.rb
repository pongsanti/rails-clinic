class ApartmentCustomElevator < Apartment::Elevators::Generic

  # @return {String} - The tenant to switch to
  def parse_tenant_name(request)

    begin
      user_id = get_user_id(request)
      user = user(user_id)
      return user.client.subdomain
    rescue
      # User got no client yet
      return unauth
    else
      # should not be reached
      return unauth
    end

  end

  private
    def get_user_id(request)
      request.env['rack.session']['warden.user.user.key'][0][0]
    end

    def user(id)
      User.find(id)
    end

    # Check authorization of user's client by Devise
    # Let user in even if he's got no cilent with 'public' schema
    # He will be rejected anyway
    def unauth
      #raise Apartment::TenantNotFound
      nil
    end
end