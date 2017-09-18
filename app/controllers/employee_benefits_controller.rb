class EmployeeBenefitsController < ApplicationController

  before_action :set_employee, only: [:upload_template, :upload_benefit_doc]

  def index
    @templates = EmpBenefitDoc.templates
    @uploaded_docs = current_employee.emp_benefit_docs.where("template_type is NOT NULL and template =?", false)
    @template_types = EmpBenefitDoc.templates.pluck(:template_type)
    @all_user_docs = EmpBenefitDoc.where("template_type is NOT NULL and template =? and employee_id !=?", false, current_employee.id)
  end

  def show
    @document = EmpBenefitDoc.find(params[:id])
    send_file(@document.document.path, :filename => @document.document_file_name, :disposition => 'inline', :type => "application/pdf")
  end

  def upload_template
    if params[:documents]
      params[:documents].each { |document|
        @employee.emp_benefit_docs.create(
          document: document,
          template: 1,
          template_type: params["emp_benefit_doc"]["template_type"]
        )
      }
    end
    redirect_to employee_benefits_path
  end

  def download_emp_benefit_doc
    @document = EmpBenefitDoc.find(params[:id])
    send_file(@document.document.path)
  end

  def upload_benefit_doc
    if params[:documents]
      params[:documents].each { |document|
        @employee.emp_benefit_docs.create(
          document: document,
          template: 0,
          template_type: params["emp_benefit_doc"]["template_type"]
        )
      }
    end
    redirect_to employee_benefits_path
  end

  def delete_emp_benefit_doc
    @document = EmpBenefitDoc.find(params[:id])
    @document.destroy
    redirect_to employee_benefits_path
  end


  private
    def set_employee
      @employee = Employee.find(params[:id])
    end
end
