class SignaturesController < ApplicationController
  before_action :set_employee, only: [:create]
  before_action :set_signature, only: [:destroy, :download]

  def index
    @signatures = current_employee.signatures
    @signature = Signature.new
  end

  def create
    sign = Paperclip.io_adapters.for(params[:signature][:sign])
    @employee.signatures.create(sign: sign, sign_file_name: "#{params[:signature][:sign_file_name]}.png")

    redirect_to user_signatures_path
  end

  def download
    send_file(@signature.sign.path)
  end

  def destroy
    @signature.destroy

    redirect_to user_signatures_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signature
      @signature = Signature.find(params[:id])
    end

    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def signature_params
      params.require(:signature).permit(:sign)
    end
end
