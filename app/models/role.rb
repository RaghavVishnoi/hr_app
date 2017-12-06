class Role < ApplicationRecord
  has_many :employees
  has_many :default_modules
end
