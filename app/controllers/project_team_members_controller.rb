class ProjectTeamMembersController < ApplicationController
    def new
    @project_team_member = ProjectTeamMember.new
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
    redirect_to project_team_members_path
  end

  def update
    @project_team_member = ProjectTeamMember.find(params[:id])
    @project_team_member.update(project_team_member_params)
    redirect_to project_team_members_path
  end

  private
    def project_team_member_params
      params.require(:project_team_member).permit(:employee_id, :project_team_id)
    end
end
