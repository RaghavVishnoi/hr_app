class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    @team_results = Team.eager_load([exams: :results], :employees).order(created_at: :desc)
  end

  def exam_result
    @results = Exam.find(params[:exam_id]).results
    render 'index'
  end

  def employee_result
    if current_employee.user_role == 'employee'
      @results = current_employee.results.where(status: true)
    else
      @results = employee.find(params[:employee_id]).results
    end
  end

  def filter_result
    query_denerator
    render 'index'
  end

  def print
    @result = Result.find(params['result'])
    html = render_to_string 'show.html.erb', :layout => false 
    kit = PDFKit.new(html, page_size: 'A4')
    
    respond_to do |format|
      format.html { render 'show' }
      format.pdf { send_data(kit.to_pdf, filename: "#{@result.employee.fullname}_result.pdf", type: 'application/pdf') }
    end
  end

  def print_team_result
    @team = Team.find(params[:team_id])
    @exams = @team.exams.eager_load([results: :employee]).where.not(results: {exam_id: nil} ).order(created_at: :desc)
    html = render_to_string 'team_results.html.erb', :layout => false 
    kit = PDFKit.new(html, page_size: 'A4')
    
    respond_to do |format|
      format.html { render 'team_results' }
      format.pdf { send_data(kit.to_pdf, filename: "#{@team.name}_result.pdf", type: 'application/pdf') }
    end
  end

  def activate_result
    @result = Result.where(exam_id: params[:exam_id])
    @result.update(status: true)
    respond_to do |format|
      format.js
    end
  end

  def inactivate_result
    @result = Result.where(exam_id: params[:exam_id])
    @result.update(status: false)
    respond_to do |format|
      format.js
    end
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    flash[:alert] = 'Result can not be created manually'
    redirect_to results_path
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def share
    if params[:receiver].present?
      employees = Employee.where(id: params[:receiver])
      if employees.present?
        result = Result.find(params[:result_id])
        ResultMailer.send_result(result,employees,current_employee).deliver_now
        redirect_to exams_path,notice: "Successfully shared!"
      else
        redirect_to exams_path,notice: "Employee not found!"
      end  
     else
      redirect_to exams_path,notice: "Please select receivers!"
     end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:employee_id, :exam_id, :obtained_marks, :correct_ans, :incorrect_ans)
    end

    def query_denerator
      @results = Result.where(nil)
      if params[:to_date].present? && params[:from_date].present?
        @results = @results.where("create_at >= :from_date && created_at =< :to_date", { from_date: params[:from_date], to_date: params[:to_date] })
      elsif params[:to_date].present? || params[:from_date].present?
        @results = @results.where("create_at = :date", { date: params[:from_date] || params[:to_date] })
      end

      if params[:subject].present? 
        @results = @results.joins(:exam).where("exams.subject = ?", params[:subject])
      end 
      return @results
    end
end
