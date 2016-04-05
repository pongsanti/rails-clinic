class Customer < ActiveRecord::Base
	
	validates :prefix, presence: true
	validates :name, presence: true

end
