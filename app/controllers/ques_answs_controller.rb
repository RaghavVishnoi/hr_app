class QuesAnswsController < ApplicationController
  before_action :set_ques_answ, only: [:show, :edit, :update, :destroy]

  # GET /ques_answs
  # GET /ques_answs.json
  def index
    @ques_answs = QuesAnsw.all
  end

  # GET /ques_answs/1
  # GET /ques_answs/1.json
  def show
  end

  # GET /ques_answs/new
  def new
    @ques_answ = QuesAnsw.new
  end

  # GET /ques_answs/1/edit
  def edit
  end

  # POST /ques_answs
  # POST /ques_answs.json
  def create
    @ques_answ = QuesAnsw.new(ques_answ_params)

    respond_to do |format|
      if @ques_answ.save
        format.html { redirect_to @ques_answ, notice: 'Ques answ was successfully created.' }
        format.json { render :show, status: :created, location: @ques_answ }
      else
        format.html { render :new }
        format.json { render json: @ques_answ.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ques_answs/1
  # PATCH/PUT /ques_answs/1.json
  def update
    respond_to do |format|
      if @ques_answ.update(ques_answ_params)
        format.html { redirect_to @ques_answ, notice: 'Ques answ was successfully updated.' }
        format.json { render :show, status: :ok, location: @ques_answ }
      else
        format.html { render :edit }
        format.json { render json: @ques_answ.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ques_answs/1
  # DELETE /ques_answs/1.json
  def destroy
    @ques_answ.destroy
    respond_to do |format|
      format.html { redirect_to ques_answs_url, notice: 'Ques answ was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ques_answ
      @ques_answ = QuesAnsw.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ques_answ_params
      params.require(:ques_answ).permit(:answer, :question_id, :employee_id)
    end
end
