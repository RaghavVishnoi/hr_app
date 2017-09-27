class ReviewCatgQuestsController < ApplicationController
  before_action :set_review_catg_quest, only: [:show, :edit, :update, :destroy]
  before_action :set_category, only: [:create]
  # GET /review_catg_quests
  # GET /review_catg_quests.json
  def index
    @review_catg_quests = ReviewCatgQuest.all
  end

  # GET /review_catg_quests/1
  # GET /review_catg_quests/1.json
  def show
  end

  # GET /review_catg_quests/new
  def new

  end

  # GET /review_catg_quests/1/edit
  def edit
  end

  # POST /review_catg_quests
  # POST /review_catg_quests.json
  def create
    @review_catg_quest = @category.questions.new(review_catg_quest_params)

    respond_to do |format|
      if @review_catg_quest.save
        format.html { redirect_to perf_review_catgs_path, notice: 'Review catg quest was successfully created.' }
        format.json { render :show, status: :created, location: @review_catg_quest }
      else
        format.html { render :new }
        format.json { render json: @review_catg_quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /review_catg_quests/1
  # PATCH/PUT /review_catg_quests/1.json
  def update
    respond_to do |format|
      if @review_catg_quest.update(review_catg_quest_params)
        format.html { redirect_to @review_catg_quest, notice: 'Review catg quest was successfully updated.' }
        format.json { render :show, status: :ok, location: @review_catg_quest }
      else
        format.html { render :edit }
        format.json { render json: @review_catg_quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /review_catg_quests/1
  # DELETE /review_catg_quests/1.json
  def destroy
    @review_catg_quest.destroy
    respond_to do |format|
      format.html { redirect_to review_catg_quests_url, notice: 'Review catg quest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review_catg_quest
      @review_catg_quest = ReviewCatgQuest.find(params[:id])
    end

    def set_category
      @category = PerfReviewCatg.find(params[:perf_review_catg_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_catg_quest_params
      params.require(:review_catg_quest).permit(:name, :category_id)
    end
end
