class Leave < ApplicationRecord
  belongs_to :applicable, polymorphic: true, inverse_of: :employee
end
