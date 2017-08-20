class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :upload_document]
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
    @experience = Experience.new
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

end
