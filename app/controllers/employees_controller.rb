require "pdfkit"
require 'fileutils'

class EmployeesController < ApplicationController
  include EmployeesHelper
  helper_method :sort_column, :sort_direction

  before_action :set_employee, only: [:show, :edit, :update, :destroy, :upload_document]
  def index
    if current_employee.president?
      @employees = Employee.all
    elsif current_employee.hr?
      @employees = Employee.where.not(role_id: Role.where(role: 'president').ids)
    elsif current_employee.team_leader?
      @employees = Employee.where.not(role_id: Role.where(role: ['president', 'hr']).ids)
    end
    @employees = @employees.order(sort_column + " " + sort_direction)
  end

  def show
    @experience = Experience.new
  end

  def attendance_logs

    # _month_report = []
    swith_dates = current_employee.switch_days.map(&:real_date)  
    logs=current_employee.employee_usage_logs.where("DATE(created_at) = ?", Date.today)
    if logs.present?
      @remark = logs.where(entry_type: "IN").first.logs_time if logs.where(entry_type: "IN").first.logs_time.present?
    end 
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

  def archive
    employee_params = params.symbolize_keys
    coverage_id = employee_params[:employee]["coverage_id"]
    employee_id = employee_params[:employee]["employee_id"]
    employee_data = Employee.find(employee_id)
    coverage_data = Employee.find(coverage_id)
    termination_date = employee_params[:employee]["termination_date"]
    termination_comment = employee_params[:employee]["termination_comment"]
    Dir.mkdir("public/termination/termination-#{employee_id}") unless File.exists?("public/termination/termination-#{employee_id}")
    copy_disclosure_file(employee_data)
    #copy_experience_file(employee_data)
    html = EmployeesHelper.termination_template(employee_data,coverage_data,termination_date,current_employee) 
    kit = PDFKit.new(html)
    kit.to_file("public/termination/termination-#{employee_id}/archive.pdf")
    result = employee_data.update(status: "archive",comment: termination_comment)
    if result
      render json: {status: 200,message: "Successfully terminated and generated a report!"}
    else
      render json: {status: 500,error: result.errors.full_messages}
    end
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

  def sort_column
    Employee.column_names.include?(params[:sort]) ? params[:sort] : "status"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def copy_disclosure_file(employee)
    employee.disclosures.each do |disclosure|
      src = "public/disclosures/#{employee.id}/#{disclosure.id}/#{disclosure.document_file_name}"
      FileUtils.cp(src, "public/termination/termination-#{employee.id}")
    end
  end

  def copy_experience_file(employee)
    employee.documents.each do |document|
      src = "public/documents/#{employee.id}/#{document.document_file_name}"
      FileUtils.cp(src, "public/termination/termination-#{employee.id}")
    end
  end

end
