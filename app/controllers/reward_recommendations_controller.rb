class RewardRecommendationsController < ApplicationController
  before_action :set_reward_recommendation, only: [:show, :edit, :update, :destroy]

  # GET /reward_recommendations
  # GET /reward_recommendations.json
  def index
    case current_employee.role.role
    when 'employee'
      @reward_recommendations = []
    when 'team_leader'
      @reward_recommendations = RewardRecommendation.team_leader_reward_recommendation(current_employee).order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    when 'team_manager'
      @reward_recommendations = RewardRecommendation.team_manager_reward_recommendation(current_employee).order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    when 'hr'
      @reward_recommendations = RewardRecommendation.all.order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    when 'president'
      @reward_recommendations = RewardRecommendation.all.order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    end
  end

  # GET /reward_recommendations/1
  # GET /reward_recommendations/1.json
  def show
  end

  # GET /reward_recommendations/new
  def new
    @reward_recommendation = RewardRecommendation.new
  end

  # GET /reward_recommendations/1/edit
  def edit
  end

  # POST /reward_recommendations
  # POST /reward_recommendations.json
  def create
    @reward_recommendation = RewardRecommendation.new(reward_recommendation_params.merge(
                                                      employee_id: current_employee.id,
                                                      previous_awarded_month: employee_last_awarded[:month],
                                                      previous_awarded_year: employee_last_awarded[:year])
                                                     ) 
    respond_to do |format|
      if @reward_recommendation.save
        format.html { redirect_to reward_recommendations_path, notice: 'Reward recommendation was successfully created.' }
        format.json { render :show, status: :created, location: @reward_recommendation }
      else
        format.html { render :new }
        format.json { render json: @reward_recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reward_recommendations/1
  # PATCH/PUT /reward_recommendations/1.json
  def update
    respond_to do |format|
      if @reward_recommendation.update(reward_recommendation_params)
        format.html { redirect_to @reward_recommendation, notice: 'Reward recommendation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reward_recommendation }
      else
        format.html { render :edit }
        format.json { render json: @reward_recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    reward_recommendation = RewardRecommendation.find(params[:id])
    result = RewardRecommendation.update_status(reward_recommendation, params['reward_recommendation']['status'], current_employee) 
    render :json => result

  end

  # DELETE /reward_recommendations/1
  # DELETE /reward_recommendations/1.json
  def destroy
    @reward_recommendation.destroy
    respond_to do |format|
      format.html { redirect_to reward_recommendations_url, notice: 'Reward recommendation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reward_recommendation
      @reward_recommendation = RewardRecommendation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reward_recommendation_params
      params.require(:reward_recommendation).permit(:recommended_employee_id,:recommendation_month,:recommendation_year,:comment,:team_lead_id,:team_manager_id)
    end

    def employee_last_awarded
      current_employee.last_awarded
    end

end
