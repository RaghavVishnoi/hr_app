class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :upload_document]
  def index
    if current_employee.president?
      @employees = Employee.all
    elsif current_employee.hr?
      @employees = Employee.where.not(role_id: Role.where(role: 'president').ids)
    elsif current_employee.team_leader?
      @employees = Employee.where.not(role_id: Role.where(role: ['president', 'hr']).ids)
    end
  end

  def show
    @experience = Experience.new
  end

  def attendance_logs

    # _month_report = []
    swith_dates = current_employee.switch_days.map(&:real_date)  
    logs=current_employee.employee_usage_logs.where("DATE(created_at) = ?", Date.today)
    @remark = logs.where(entry_type: "IN").first.logs_time
    if logs.where(entry_type: "IN").first.present? && logs.where(entry_type: "OUT").last.present?
	    start_time = logs.in_log
	    end_time =  logs.out_log
    else
       start_time = 0
       end_time = 0 
    end
      if start_time.present? && end_time.present?
        @minutes = time_diff(start_time, end_time).abs
      end

         total_seconds = @minutes * 60
         @hours = total_seconds / (60 * 60)
         @minutes = (total_seconds / 60) % 60
         @seconds = total_seconds % 60
  end

  def edit
  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    if @employee.update(employee_params)
      flash[:notice] = 'Exam was successfully updated.'
    end
    redirect_to employees_path
  end

  def upload_document
    if params[:documents]
      params[:documents].each { |document|
        @employee.documents.create(document: document)
      }
    end
    redirect_to employee_profile_path(@employee)
  end

  private

    def set_employee
      @employee = Employee.find(params[:id])
    end


    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :email, :role_id)
    end

    def time_diff(start_time, end_time)
        (start_time -  end_time) / 60
    end

end
