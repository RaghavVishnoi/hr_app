require 'htmltoword'
class PerfReviewsController < ApplicationController
  respond_to :html, :js, :docx

  before_action :set_perf_review, only: [:show, :edit, :update, :destroy, :download_pdf]
  skip_before_filter :verify_authenticity_token, only: [:password]
  # GET /perf_reviews
  # GET /perf_reviews.json
  def index
    if current_employee.hr?
      @perf_review_employees = Employee.joins("LEFT JOIN perf_reviews ON perf_reviews.employee_id = employees.id").group('employees.id').paginate(:page => params[:page], :per_page => 10)
      @perf_review = PerfReview.new
    else
      @perf_review_employees = Employee.joins("LEFT JOIN perf_reviews ON perf_reviews.employee_id = employees.id where perf_reviews.reviewer_id=#{current_employee.id}").group('employees.id').paginate(:page => params[:page], :per_page => 10)
      @perf_review = PerfReview.new
    end
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

  def password
    password = params[:review_password]
    data_type = params[:data_module]
    data_module = DataPassword.where('data_type = ? AND employee_id = ? AND expiry_date >= ?',data_type, current_employee.id, Date.current)
    if data_module.present?
      if BCrypt::Password.new(data_module.last.password_digest) == password 
        render :json => {status: 200}
      else
        render :json => {status: 422}
      end
    else
      render :json => {status: 401}
    end
  end

  def employee_review
    @perf_reviews = PerfReview.where(employee_id: params[:employee_id])
    @employee = Employee.find(params[:employee_id])
  end

  def print_reviews
    employee = Employee.find(params[:employee_id])
    @perf_reviews = PerfReview.where(employee_id: params[:employee_id])
    respond_to do |format|
      format.docx do
        render docx: 'print_reviews', filename: "#{employee.name}-#{Date.today}.docx"
      end
    end
  end

  # POST /perf_reviews
  # POST /perf_reviews.json
  def create
    review = PerfReview.new(perf_review_params)
    if review.save(validate: false)
      if params[:answers].present?
        params[:answers].each do |answer|
          ques_id = answer.split("_")[1]
          quest = ReviewCatgQuest.find(ques_id)
          quest.answers.create(
            answer: params["answers"][answer],
            employee_id: current_employee.id,
            review_id: review.id
          )
        end
      end  
      review.update_average_point
      review.update_flag
      redirect_to perf_reviews_path
    else
      redirect_to "/request/#{params[:reviewer_id]}/send_review",notice: review.errors.full_messages.join(",")
    end  
  end

  # PATCH/PUT /perf_reviews/1
  # PATCH/PUT /perf_reviews/1.json
  def update
    perf_review = @perf_review.update(perf_review_params)
    if perf_review
      params[:answers].each do |answer|
        ques_id = answer.split("_")[1]
        quest = ReviewCatgQuest.find(ques_id)
        quest.answers.where(review_id: @perf_review.id).first.update(
          answer: params["answers"][answer]
        )
      end
      @perf_review.update_average_point
      redirect_to "/perf_reviews/#{@perf_review.employee.id}/employee"
    else
      redirect_to "/perf_reviews/#{params[:id]}/edit", notice: "Please check the values!"
    end  
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
      params.require(:perf_review).permit(:employee_id,:name,:time_in_position,:job_title,:last_appraisal,:team_leader,:first_prepared,:hiring_date,:reviewer_id,:prepared_by,:request_id,:comment,:catg_reviews)
    end
end
