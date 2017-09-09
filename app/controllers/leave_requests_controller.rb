class LeaveRequestsController < ApplicationController
  def index
  	@leave_requests = Leave.where(assigned_to: current_employee.id)
	 	

  	if current_employee.team_leader?
  		team_members = current_employee.project_team_member.project_team.project_team_members.pluck(:employee_id)	
  		leaves = Leave.where(employee_id: team_members)
  		@leave_requests=leaves.where.not(employee_accepted_at: nil)
  	elsif current_employee.team_manager?
  		team_members = current_employee.project_team_member.project_team.project_team_members.pluck(:employee_id)	
  		leaves = Leave.where(employee_id: team_members)
  		@leave_requests=leaves.where.not(employee_accepted_at: nil,tl_accepted_at: nil)
  	elsif current_employee.hr?	
  		@leave_requests=Leave.where.not(employee_accepted_at: nil,tl_accepted_at: nil,tm_accepted_at: nil)
  	elsif current_employee.president?
  		@leave_requests=Leave.where.not(employee_accepted_at: nil,tl_accepted_at: nil,tm_accepted_at: nil,hr_accepted_at: nil) 	
  	end
  end
end
