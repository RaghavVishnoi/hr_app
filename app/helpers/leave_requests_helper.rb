module LeaveRequestsHelper

  def find_assigned_to
    if current_employee.employee?
      Employee.where(id: current_employee.project_team_member.project_team.project_team_members.pluck(:employee_id)).where(role_id: 5).first.id
    elsif current_employee.team_leader?
      Employee.where(id: current_employee.project_team_member.project_team.project_team_members.pluck(:employee_id)).where(role_id: 4).first.id
    elsif current_employee.team_manager?
      Employee.where(role_id: 3).first.id
    elsif current_employee.hr?
      Employee.where(role_id: 2).first.id
    elsif current_employee.hr?
      Employee.where(role_id: 1).first.id
    end 
  end
end
