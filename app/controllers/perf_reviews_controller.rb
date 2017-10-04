class PerfReviewsController < ApplicationController
  before_action :set_perf_review, only: [:show, :edit, :update, :destroy, :download_pdf]

  # GET /perf_reviews
  # GET /perf_reviews.json
  def index
    if current_employee.hr?
      @perf_reviews = PerfReview.all
    else
      @perf_reviews = current_employee.perf_reviews
    end
    @perf_review = PerfReview.new
  end

  # GET /perf_reviews/1
  # GET /perf_reviews/1.json
  def show
  end

  # GET /perf_reviews/new
  def new
    @reviewer = PerfReviewReviewer.find(params[:reviewer_id])
  end

  # GET /perf_reviews/1/edit
  def edit
  end

  # POST /perf_reviews
  # POST /perf_reviews.json
  def create
    pending_review = PerfReviewReviewer.find(params[:reviewer_id])
    employee = Employee.find_by(email: params[:reviewee_email])
    review = PerfReview.create(
      employee_id: employee.id,
      name: params[:perf_review][:name],
      time_in_position: params[:perf_review][:time_in_position],
      job_title: params[:perf_review][:job_title],
      last_appraisal: params[:perf_review][:last_appraisal],
      team_leader: params[:perf_review][:team_leader],
      first_prepared: params[:perf_review][:first_prepared],
      hiring_date: params[:perf_review][:hiring_date],
      reviewer_id: current_employee.id,
      prepared_by: params[:perf_review][:prepared_by],
      request_id: params[:reviewer_id]
    )
    params[:answers].each do |answer|
      ques_id = answer.split("_")[1]
      quest = ReviewCatgQuest.find(ques_id)
      quest.answers.create(
        answer: params["answers"][answer],
        employee_id: current_employee.id,
        review_id: review.id
      )
    end
    review.update_average_point
    review.update_flag
    redirect_to perf_reviews_path
  end

  # PATCH/PUT /perf_reviews/1
  # PATCH/PUT /perf_reviews/1.json
  def update
    employee = Employee.find_by(email: params[:reviewee_email])
    @perf_review.update(
      employee_id: employee.id,
      name: params[:perf_review][:name],
      time_in_position: params[:perf_review][:time_in_position],
      job_title: params[:perf_review][:job_title],
      last_appraisal: params[:perf_review][:last_appraisal],
      team_leader: params[:perf_review][:team_leader],
      first_prepared: params[:perf_review][:first_prepared],
      hiring_date: params[:perf_review][:hiring_date],
      reviewer_id: current_employee.id,
      prepared_by: params[:perf_review][:prepared_by],
      request_id: params[:reviewer_id]
    )
    params[:answers].each do |answer|
      ques_id = answer.split("_")[1]
      quest = ReviewCatgQuest.find(ques_id)
      quest.answers.where(review_id: @perf_review.id).first.update(
        answer: params["answers"][answer]
      )
    end
    @perf_review.update_average_point
    redirect_to perf_reviews_path
  end

  # DELETE /perf_reviews/1
  # DELETE /perf_reviews/1.json
  def destroy
    @perf_review.destroy
    respond_to do |format|
      format.html { redirect_to perf_reviews_url, notice: 'Perf review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_pdf
    respond_to  do |format|
        format.html
        format.pdf
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perf_review
      @perf_review = PerfReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perf_review_params
      params.require(:perf_review).permit(:name, :employee_id, :time_in_position, :job_title, :last_appraisal, :team_leader, :first_prepared, :hiring_date, :prepared_by, :catg_reviews, :avg, :reviewer_id)
    end
end
