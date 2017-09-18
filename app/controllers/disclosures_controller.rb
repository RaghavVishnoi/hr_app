class DisclosuresController < ApplicationController

  before_action :set_employee, only: [:upload_disclosure_template, :upload_disclosure_doc]

  def index
    @templates = Disclosure.templates
    @uploaded_docs = current_employee.disclosures.where("template =?", false)
    @all_user_docs = Disclosure.where("template =? and employee_id !=?", false, current_employee.id)
  end

  def show
    @document = Disclosure.find(params[:id])
    send_file(@document.document.path, :filename => @document.document_file_name, :disposition => 'inline', :type => "application/pdf")
  end

  def upload_disclosure_template
    if params[:documents]
      params[:documents].each { |document|
        @employee.disclosures.create(
          document: document,
          template: 1
        )
      }
    end
    redirect_to disclosures_path
  end

  def download_disclosure_doc
    @document = Disclosure.find(params[:id])
    send_file(@document.document.path)
  end

  def upload_disclosure_doc
    if params[:documents]
      params[:documents].each { |document|
        @employee.disclosures.create(
          document: document,
          template: 0
        )
      }
    end
    redirect_to disclosures_path
  end

  def delete_disclosure_doc
    @document = Disclosure.find(params[:id])
    @document.destroy
    redirect_to disclosures_path
  end


  private
    def set_employee
      @employee = Employee.find(params[:id])
    end
end
