class Client < ActiveRecord::Base

  after_create :create_tenant

  ID_PREFIX = "CL"

  has_many :users, inverse_of: :client

  private
    def create_tenant
      Apartment::Tenant.create(subdomain)
    end

end