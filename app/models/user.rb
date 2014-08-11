class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true, length:{ maximum: 50 }
	VALID_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true , format: { with: VALID_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }
	#validates_confirmation_of :password, if: lambda { |m| m.password.present? }
end