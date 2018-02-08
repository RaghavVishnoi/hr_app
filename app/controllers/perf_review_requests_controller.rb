require 'htmltoword'
class PerfReviewRequestsController < ApplicationController
  include EmployeesHelper
  respond_to :html, :js, :docx
  before_action :set_perf_review_request, only: [:show, :edit, :update, :destroy]

  # GET /perf_review_requests
  # GET /perf_review_requests.json
  def index
    @perf_review_requests = PerfReviewRequest.all.order('due_date asc').paginate(:page => params[:page], :per_page => 5)
  end

  # GET /perf_review_requests/1
  # GET /perf_review_requests/1.json
  def show
  end

  # GET /perf_review_requests/new
  def new
    @perf_review_request = PerfReviewRequest.new
  end

  # GET /perf_review_requests/1/edit
  def edit
  end

  # POST /perf_review_requests
  # POST /perf_review_requests.json
  def create
    reviewee_id = params[:reviewee_id]
    # if PerfReviewRequest.already_exists?()
    #   notice = "Sorry! You have already pending request for this employee, with this respecitve employee."
    # else
      request = PerfReviewRequest.create(
        reviewee_id: reviewee_id,
        employee_id: current_employee.id,
        job_title: params[:job_title],
        time_in_position: params[:time_in_position],
        last_appraisal: params[:last_appraisal],
        first_prepared: params[:first_prepared],
        hiring_date: params[:hiring_date],
        due_date: params[:due_date]
      )

      params[:reviewer_id].each do |reviewer_id|
        PerfReviewReviewer.create(
          perf_review_request_id: request.id,
          reviewer_id: reviewer_id,
          flag: false
        )
      end
      notice = 'Your request was successfully created.'
    # end
    respond_to do |format|
      format.html { redirect_to perf_review_requests_path, notice: notice }
    end
  end

  # PATCH/PUT /perf_review_requests/1
  # PATCH/PUT /perf_review_requests/1.json
  def update
    @perf_review_request = PerfReviewRequest.find(params[:id])
    @perf_review_request.update_attributes(
      reviewee_id: params[:reviewee_id],
      employee_id: current_employee.id,
      job_title: params[:job_title],
      time_in_position: params[:time_in_position],
      last_appraisal: params[:last_appraisal],
      first_prepared: params[:first_prepared],
      hiring_date: params[:hiring_date],
      due_date: params[:due_date]
    )
    initial_reviewers = @perf_review_request.reviewers.pluck(:reviewer_id) rescue []
    reviewed_reviewers = @perf_review_request.reviewed_reviewers.pluck(:id) rescue []
    reviewer_retain = params[:reviewer_id].map{|ri| Integer(ri)} rescue []
    new_reviewers = reviewer_retain - initial_reviewers
    if new_reviewers.present?
      new_reviewers.each do |new_reviewer|
        PerfReviewReviewer.create(perf_review_request_id: @perf_review_request.id,reviewer_id: new_reviewer,flag: false)
      end
    end
    reviewer_to_delete = initial_reviewers - (reviewed_reviewers + reviewer_retain) rescue []
    PerfReviewReviewer.where(reviewer_id: reviewer_to_delete).destroy_all rescue nil
    respond_to do |format|
      if @perf_review_request
        format.html { redirect_to perf_review_requests_path, notice: 'Perf review request was successfully updated.' }
        format.json { render :show, status: :ok, location: @perf_review_request }
      else
        format.html { render :edit }
        format.json { render json: @perf_review_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def details
    @perf_review_request = PerfReviewRequest.find(params[:id]) 
  end

  def resend
    begin
      @perf_review_request = PerfReviewRequest.find(params[:id])
      if params[:reviewer_id].present?
        @perf_review_reviewers = @perf_review_request.reviewers.where(reviewer_id: params[:reviewer_id])
      else
        @perf_review_reviewers = @perf_review_request.reviewers
      end  
      @perf_reviews = PerfReview.where(request_id: @perf_review_reviewers.pluck(:id))
      if @perf_reviews.destroy_all
        if @perf_review_reviewers.update_all(flag: false)
          redirect_to perf_review_requests_path,notice: 'Request successfully reinitiate!'
        else
          redirect_to request.referrer,notice: @@perf_review_reviewers.errors.full_messages
        end
      else
        redirect_to request.referrer,notice: @perf_reviews.errors.full_messages
      end
    rescue => e
      redirect_to request.referrer,notice: e.message
    end  
  end

  # DELETE /perf_review_requests/1
  # DELETE /perf_review_requests/1.json
  def destroy
    @perf_review_request.destroy
    respond_to do |format|
      format.html { redirect_to perf_review_requests_url, notice: 'Perf review request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report_all
    @perf_review_requests = PerfReviewRequest.all.order('due_date asc')
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"Review Requests All-#{DateTime.current.strftime('%d %b,%Y %T')}.doc\"" }
    end
  end

  def report
    @perf_review_request = set_perf_review_request
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\"Review Requests-#{DateTime.current.strftime('%d %b,%Y %T')}.doc\"" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perf_review_request
      @perf_review_request = PerfReviewRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perf_review_request_params
      params.require(:perf_review_request).permit(:reviewee_id, :flag, :avg, :job_title,:time_in_position ,:last_appraisal, :first_prepared, :hiring_date, :reviewer_id => [])
    end
end
