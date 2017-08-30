class SwitchDaysController < ApplicationController
  
  def index
    @switch_days = current_employee.switch_days
  end

  def show
  end

  def new

    @switch_day = SwitchDay.new
  end

  def edit
  end

  def create
    @switch_day = SwitchDay.new(switch_day_params)
    EmployeeUsageLog.create(employee_id: current_employee.id, entry_type: "IN",logs_time: "This day is replace by #{switch_day_params[:replace_date]}",created_at: switch_day_params[:real_date].to_date)
      if @switch_day.save
       redirect_to switch_days_path
      else
        render :new
      end
   end

  def update
    respond_to do |format|
      if @experience.update(switch_day_params)
        format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @experience }
      else
        format.html { render :edit }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @experience.destroy
    respond_to do |format|
      format.html { redirect_to experiences_url, notice: 'Experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_experience
      @experience = Experience.find(params[:id])
    end

    def switch_day_params
      params.require(:switch_day).permit(:real_date, :replace_date, :employee_id)
    end
end

