class DocumentsController < ApplicationController

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    respond_to do |format|
      format.html { redirect_to employee_profile_path(@document.employee), notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    @document = Document.find(params[:id])
    redirect_to @document.document.url
  end
end

