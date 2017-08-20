class LeaveRequestsController < ApplicationController
  def index
  	@leave_requests = Leave.where(assigned_to: current_employee.id)
  end
end
