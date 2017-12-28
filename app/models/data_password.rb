class DataPassword < ApplicationRecord
	has_secure_password
	belongs_to :employee

	before_update :update_encrypt_password
	before_create :encrypt_password

	private
		def encrypt_password
			self.password_digest = BCrypt::Password.create self.password_digest
		end

		def update_encrypt_password
			self.password_digest = BCrypt::Password.create self.password_digest
		end

end
