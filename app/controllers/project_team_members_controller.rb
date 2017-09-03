class ProjectTeamMembersController < ApplicationController
  def new
    @project_team_member = ProjectTeamMember.new
    if ProjectTeam.find(params[:pt]).project_team_members.includes(:employee).where(employees: { role_id: Role.find_by(role: "team_leader") }).present?
      @emp_team = Employee.joins(:role).where("roles.role in (?)", ["employee", "team_manager"]).not_added
    elsif ProjectTeam.find(params[:pt]).project_team_members.includes(:employee).where(employees: { role_id: Role.find_by(role: "team_manager") }).present?
      @emp_team = Employee.joins(:role).where("roles.role in (?)", ["employee", "team_leader"]).not_added
    else
      @emp_team = Employee.members.not_added
    end

    @team = ProjectTeam.find(params[:pt]).project_team_members

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @project_team_member = ProjectTeamMember.find(params[:id])
  end

  def index
    @project_team_members = ProjectTeamMember.all
  end

  def show
    @project_team_member = ProjectTeamMember.find(params[:id])
  end

  def create
    @project_team_member = ProjectTeamMember.new(project_team_member_params)
    @project_team_member.save

    if ProjectTeam.find(params[:project_team_member][:project_team_id]).project_team_members.includes(:employee).where(employees: { role_id: Role.find_by(role: "team_leader") }).present?
      @emp_team = Employee.joins(:role).where("roles.role in (?)", ["employee", "team_manager"]).not_added
    elsif ProjectTeam.find(params[:project_team_member][:project_team_id]).project_team_members.includes(:employee).where(employees: { role_id: Role.find_by(role: "team_manager") }).present?
      @emp_team = Employee.joins(:role).where("roles.role in (?)", ["employee", "team_leader"]).not_added
    else
      @emp_team = Employee.members.not_added
    end

    @team = ProjectTeam.find(params[:project_team_member][:project_team_id]).project_team_members

    respond_to do |format|
      format.js
    end
  end

  def update
    @project_team_member = ProjectTeamMember.find(params[:id])
    @project_team_member.update(project_team_member_params)
    redirect_to project_team_members_path
  end

  def destroy
    @project_team_member = ProjectTeamMember.find_by(employee_id: params[:employee_id], project_team_id: params[:project_team_id])
    @project_team_member.destroy

    if ProjectTeam.find(params[:project_team_id]).project_team_members.includes(:employee).where(employees: { role_id: Role.find_by(role: "team_leader") }).present?
      @emp_team = Employee.joins(:role).where("roles.role in (?)", ["employee", "team_manager"]).not_added
    elsif ProjectTeam.find(params[:project_team_id]).project_team_members.includes(:employee).where(employees: { role_id: Role.find_by(role: "team_manager") }).present?
      @emp_team = Employee.joins(:role).where("roles.role in (?)", ["employee", "team_leader"]).not_added
    else
      @emp_team = Employee.members.not_added
    end

    @team = ProjectTeam.find(params[:project_team_id]).project_team_members

    respond_to do |format|
      format.js
    end
  end

  def org_team_chart
    @team_managers = Employee.team_managers
    @team_leaders = Employee.team_leaders
    @project_teams = ProjectTeam.all
  end

  private
    def project_team_member_params
      params.require(:project_team_member).permit(:employee_id, :project_team_id)
    end
end
