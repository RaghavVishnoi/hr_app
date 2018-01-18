class PerfReviewCatgsController < ApplicationController
  before_action :set_perf_review_catg, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :docx
  # GET /perf_review_catgs
  # GET /perf_review_catgs.json
  def index
    @perf_review_catgs = PerfReviewCatg.all
    @perf_review_catg = PerfReviewCatg.new
    @review_catg_quest = ReviewCatgQuest.new
  end

  # GET /perf_review_catgs/1
  # GET /perf_review_catgs/1.json
  def show
  end

  # GET /perf_review_catgs/new
  def new
  end

  # GET /perf_review_catgs/1/edit
  def edit
  end

  # POST /perf_review_catgs
  # POST /perf_review_catgs.json
  def create
    @perf_review_catg = PerfReviewCatg.new(perf_review_catg_params)

    respond_to do |format|
      if @perf_review_catg.save
        format.html { redirect_to perf_review_catgs_url, notice: 'Perf review catg was successfully created.' }
        format.json { render :show, status: :created, location: @perf_review_catg }
      else
        format.html { render :new }
        format.json { render json: @perf_review_catg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perf_review_catgs/1
  # PATCH/PUT /perf_review_catgs/1.json
  def update
    respond_to do |format|
      if @perf_review_catg.update(perf_review_catg_params)
        format.html { redirect_to @perf_review_catg, notice: 'Perf review catg was successfully updated.' }
        format.json { render :show, status: :ok, location: @perf_review_catg }
      else
        format.html { render :edit }
        format.json { render json: @perf_review_catg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perf_review_catgs/1
  # DELETE /perf_review_catgs/1.json
  def destroy
    @perf_review_catg.destroy
    respond_to do |format|
      format.html { redirect_to perf_review_catgs_url, notice: 'Perf review catg was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def export_all
    @perf_review_catgs = PerfReviewCatg.all
    # respond_to do |format|
    #   format.docx { headers["Content-Disposition"] = "attachment; filename=\"Review Template-#{DateTime.current.strftime('%d %b,%Y %T')}.doc\"" }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perf_review_catg
      @perf_review_catg = PerfReviewCatg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perf_review_catg_params
      params.require(:perf_review_catg).permit(:name, :employee_id)
    end
end
