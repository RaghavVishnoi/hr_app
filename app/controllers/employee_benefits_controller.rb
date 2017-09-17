class EmployeeBenefitsController < ApplicationController

  before_action :set_employee, only: [:upload_template, :upload_benefit_doc]
  DOCS_PATH = File.join(Rails.root, "public", "documents")

  def index
    @templates = Document.templates
    @uploaded_docs = current_employee.documents.where("document_type is NOT NULL and template =?", false)
    @template_types = Document.templates.pluck(:document_type)
    @all_user_docs = Document.where("document_type is NOT NULL and template =? and employee_id !=?", false, current_employee.id)
  end

  def upload_template
    if params[:documents]
      params[:documents].each { |document|
        @employee.documents.create(
          document: document,
          template: 1,
          document_type: params["document"]["document_type"]
        )
      }
    end
    redirect_to employee_benefits_path
  end

  def download_template
    @document = Document.find(params[:id])
    send_file(File.join(DOCS_PATH, "#{@document.id}/#{@document.document_file_name}"))
  end

  def upload_benefit_doc
    if params[:documents]
      params[:documents].each { |document|
        @employee.documents.create(
          document: document,
          template: 0,
          document_type: params["document"]["document_type"]
        )
      }
    end
    redirect_to employee_benefits_path
  end

  def download_benefit_doc
    @document = Document.find(params[:id])
    send_file(File.join(DOCS_PATH, "#{@document.id}/#{@document.document_file_name}"))
  end


  private
    def set_employee
      @employee = Employee.find(params[:id])
    end
end
