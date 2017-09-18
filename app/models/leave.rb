class Leave < ApplicationRecord
  # belongs_to :applicable, polymorphic: true, inverse_of: :employee
  # belongs_to :acceptable, polymorphic: true, inverse_of: :role
   belongs_to :employee
   has_many :leave_work_assigns, class_name: "LeaveWorkAssign", foreign_key: "leave_id"

   # accepts_nested_attributes_for :leave_work_assign
end
