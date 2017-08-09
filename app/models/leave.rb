class Leave < ApplicationRecord
  belongs_to :applicable, polymorphic: true, inverse_of: :employee
  belongs_to :acceptable, polymorphic: true, inverse_of: :role
end
