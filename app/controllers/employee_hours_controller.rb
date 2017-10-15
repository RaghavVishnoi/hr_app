class EmployeeHoursController < ApplicationController
  before_action :set_employee_hour, only: [:show, :edit, :update, :destroy]

  # GET /employee_hours
  # GET /employee_hours.json
  def index
    @employee_hours = EmployeeHour.all
  end

  # GET /employee_hours/1
  # GET /employee_hours/1.json
  def show
    @from = params[:from]
    @to = params[:to]
    if params[:from].present? && params[:to].present?  && params[:commit] == 'Search'
      @employee_hour_histories = EmployeeHourHistory.where(start_date: Date.strptime(params[:from], "%d/%m/%Y")..Date.strptime(params[:to], "%d/%m/%Y"),employee_hour_id: params[:id])
      @history = true
    else
      if params[:commit] == 'Search'
        @employee_hour_histories = []
        @history = true
      else
        @employee_hour_histories = []
        @history = false
        @from = ""
        @to = ""
      end
    end
  end

  # GET /employee_hours/new
  def new
    @employee_hour = EmployeeHour.new
  end

  # GET /employee_hours/1/edit
  def edit
  end

  # POST /employee_hours
  # POST /employee_hours.json
  def create
    @employee_hour = EmployeeHour.new(employee_hour_params)

    respond_to do |format|
      if @employee_hour.save
        format.html { redirect_to employee_hours_path, notice: 'Employee hour was successfully created.' }
        format.json { render :show, status: :created, location: @employee_hour }
      else
        format.html { render :new }
        format.json { render json: @employee_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_hours/1
  # PATCH/PUT /employee_hours/1.json
  def update
    respond_to do |format|
      if @employee_hour.update(employee_hour_params)
        format.html { redirect_to employee_hours_path, notice: 'Employee hour was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_hour }
      else
        format.html { render :edit }
        format.json { render json: @employee_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_hours/1
  # DELETE /employee_hours/1.json
  def destroy
    @employee_hour.destroy
    respond_to do |format|
      format.html { redirect_to employee_hours_url, notice: 'Employee hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_hour
      @employee_hour = EmployeeHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_hour_params
      params.require(:employee_hour).permit(:employee_id,:initial_sick_hours,:available_sick_hours,:initial_vocation_hours,:available_vocation_hours)
    end
end
