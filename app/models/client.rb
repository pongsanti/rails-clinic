require 'serialize/settings'

class Client < ActiveRecord::Base

  ID_PREFIX = "CL"
  
  has_many :users, inverse_of: :client

  serialize :settings, Serialize::Settings

  private
    def create_tenant
      Apartment::Tenant.create(subdomain)
    end

end