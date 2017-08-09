class TeamsController < ApplicationController
  before_action :load_team, except: [:index, :new, :create]
  
  def index
    @teams = Team.all
    @team = Team.new
  end

  def new
    @team = Team.new
  end

  def show
    @team_members = @team.team_members
  end

  def create
    @team = Team.create(team_params)
    redirect_to @team
  end

  def update
    @team.update(team_params)
  end

  def destroy
    @team.destroy
  end

  def add_members
    Employee.where(id: (params[:ids] || params[:employee_id])).each do |employee|
      @team.team_members.build(employee_id: employee.id).save!
    end
    
    respond_to do |format|
      format.js
    end
  end

  def remove_members
    @team.team_members.where(employee_id: (params[:ids] || params[:employee_id])).delete_all
    respond_to do |format|
      format.js
    end
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end

  def load_team
    @team = Team.find(params[:id])
  end
end
