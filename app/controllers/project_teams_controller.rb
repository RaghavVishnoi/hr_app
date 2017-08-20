class ProjectTeamsController < ApplicationController
  def new
    @project_team = ProjectTeam.new
  end

  def edit
    @project_team = ProjectTeam.find(params[:id])
  end

  def index
    @project_teams = ProjectTeam.all
  end

  def show
    @project_team = ProjectTeam.find(params[:id])
  end

  def create
    @project_team = ProjectTeam.new(project_team_params)
    @project_team.save
    redirect_to project_teams_path
  end

  def update
    @project_team = ProjectTeam.find(params[:id])
    @project_team.update(project_team_params)
    redirect_to project_teams_path
  end

  private
    def project_team_params
      params.require(:project_team).permit(:name, :project_id)
    end
end
