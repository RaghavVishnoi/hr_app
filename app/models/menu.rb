class Menu < ApplicationRecord
	has_many :employees,through: :module_permissions
	has_many :module_permissions
	has_many :default_modules
end
