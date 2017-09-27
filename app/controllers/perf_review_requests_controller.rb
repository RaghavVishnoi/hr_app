class PerfReviewRequestsController < ApplicationController
  before_action :set_perf_review_request, only: [:show, :edit, :update, :destroy]

  # GET /perf_review_requests
  # GET /perf_review_requests.json
  def index
    @perf_review_requests = PerfReviewRequest.all
    @perf_review_request = PerfReviewRequest.new
  end

  # GET /perf_review_requests/1
  # GET /perf_review_requests/1.json
  def show
  end

  # GET /perf_review_requests/new
  def new

  end

  # GET /perf_review_requests/1/edit
  def edit
  end

  # POST /perf_review_requests
  # POST /perf_review_requests.json
  def create
    params["perf_review_request"]["reviewer_id"].shift
    @perf_review_request = PerfReviewRequest.new(perf_review_request_params)
    @perf_review_request.employee_id = current_employee.id
    respond_to do |format|
      if @perf_review_request.save
        format.html { redirect_to @perf_review_request, notice: 'Perf review request was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @perf_review_request }
      else
        format.html { render :new }
        format.js
        format.json { render json: @perf_review_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perf_review_requests/1
  # PATCH/PUT /perf_review_requests/1.json
  def update
    respond_to do |format|
      if @perf_review_request.update(perf_review_request_params)
        format.html { redirect_to @perf_review_request, notice: 'Perf review request was successfully updated.' }
        format.json { render :show, status: :ok, location: @perf_review_request }
      else
        format.html { render :edit }
        format.json { render json: @perf_review_request.errors, status: :unprocessable_entity }
      end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perf_review_request
      @perf_review_request = PerfReviewRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perf_review_request_params
      params.require(:perf_review_request).permit(:reviewee_id, :flag, :avg, :reviewer_id => [])
    end
end
