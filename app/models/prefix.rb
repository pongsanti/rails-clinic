class Prefix < ActiveRecord::Base

	has_many :customers

  default_scope { order("id asc") }
	
end
