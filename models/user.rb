require 'bcrypt'
# require_relative "../db/connection"




class User < ActiveRecord::Base
	validates_presence_of :user_name, :email, :password_digest, presence: true
	has_many :posts
	has_many :pets

	def authenticate(login_password)
		existing_password = BCrypt::Password.new(self.password_digest)
		if existing_password == login_password
			return true
		else
			return false
		end
	end

end