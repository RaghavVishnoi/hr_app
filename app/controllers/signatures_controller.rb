class SignaturesController < ApplicationController
  before_action :set_employee, only: [:create]
  before_action :set_signature, only: [:show, :edit, :update, :destroy]

  def index
    @signatures = Signature.all
    @signature = Signature.new
  end

  def create
    sign = Paperclip.io_adapters.for(params[:signature][:sign])
    @employee.signatures.create(sign: sign)
    redirect_to user_signatures_path
  end

  def destroy
    @signature.destroy
    respond_to do |format|
      format.html { redirect_to signatures_url, notice: 'Signature was successfully destroyed.' }
      format.json { head :no_content }
    end
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
