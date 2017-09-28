class PerfReviewsController < ApplicationController
  before_action :set_perf_review, only: [:show, :edit, :update, :destroy]

  # GET /perf_reviews
  # GET /perf_reviews.json
  def index
    @perf_reviews = PerfReview.all
    @perf_review = PerfReview.new
  end

  # GET /perf_reviews/1
  # GET /perf_reviews/1.json
  def show
  end

  # GET /perf_reviews/new
  def new

  end

  # GET /perf_reviews/1/edit
  def edit
  end

  # POST /perf_reviews
  # POST /perf_reviews.json
  def create
    @perf_review = PerfReview.new(perf_review_params)

    respond_to do |format|
      if @perf_review.save
        format.html { redirect_to @perf_review, notice: 'Perf review was successfully created.' }
        format.json { render :show, status: :created, location: @perf_review }
      else
        format.html { render :new }
        format.json { render json: @perf_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perf_reviews/1
  # PATCH/PUT /perf_reviews/1.json
  def update
    respond_to do |format|
      if @perf_review.update(perf_review_params)
        format.html { redirect_to @perf_review, notice: 'Perf review was successfully updated.' }
        format.json { render :show, status: :ok, location: @perf_review }
      else
        format.html { render :edit }
        format.json { render json: @perf_review.errors, status: :unprocessable_entity }
      end
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
