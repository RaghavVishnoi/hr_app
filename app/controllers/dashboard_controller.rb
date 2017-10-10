class DashboardController < ApplicationController
  def index
    case current_employee.user_role
    when 'employee'
      @exams = Exam.eager_load(team: :team_members).where("team_members.employee_id = ?", current_employee.id)
      @results = current_employee.results
    when 'team_leader', 'hr', 'admin'
      @exams = current_employee.exams
      @active_exams = Exam.enabled 
      @results = Result.eager_load([:employee, :exams])
      @active_leaves = LeaveRequest.where(to: Time.now.beginning_of_day..Time.now.end_of_day)
    end
  # render :layout => 'dashboard'
  end
end
