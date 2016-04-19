class User < ActiveRecord::Base
	attr_accessor :password

	validates :email, uniqueness: true
	validates :password, confirmation: true
	validates :password_confirmation, presence: true

	before_save :encrypt_password

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
