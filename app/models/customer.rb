class Customer < ActiveRecord::Base

	belongs_to :prefix

	validates :prefix, presence: true
	validates :name, presence: true

end
