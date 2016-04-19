class User < ActiveRecord::Base
	attr_accessor :password

	validates :email, uniqueness: true
	validates :password, confirmation: true
	validates :password_confirmation, presence: true
end
