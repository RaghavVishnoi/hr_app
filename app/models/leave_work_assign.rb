class LeaveWorkAssign < ApplicationRecord
  belongs_to :leave
  belongs_to :employee
  # belongs_to :Leave
end
