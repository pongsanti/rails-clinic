class Prefix < ActiveRecord::Base

	has_many :customers, inverse_of: :prefix

  default_scope { order("id asc") }
	
end
