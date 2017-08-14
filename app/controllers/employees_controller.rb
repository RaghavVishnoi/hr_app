class EmployeesController < ApplicationController
  def index
    if current_employee.president?
      @employees = Employee.all
    elsif current_employee.hr?
      @employees = Employee.where.not(role_id: Role.where(role: 'president').ids)
    elsif current_employee.team_lead?
      @employees = Employee.where.not(role_id: Role.where(role: ['president', 'hr']).ids)
    end
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    
    if @employee.update(employee_params)
      flash[:notice] = 'Exam was successfully updated.'
    end
    redirect_to employees_path
  end

  private

    def set_employee
      @employee = Employee.find(params[:id])
    end


    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :email, :role_id)
    end

end
