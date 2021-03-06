class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update, :destroy]

  # GET /experiences
  # GET /experiences.json
  def index
    @experiences = Experience.all
  end

  # GET /experiences/1
  # GET /experiences/1.json
  def show
  end

  # GET /experiences/new
  def new
    @experience = Experience.new
  end

  # GET /experiences/1/edit
  def edit
  end

  # POST /experiences
  # POST /experiences.json
  def create
    @experience = Experience.new(experience_params)

    respond_to do |format|
      if @experience.save
        if last_url[:controller] == 'employees'
          format.html { redirect_to request.referer, notice: 'Experience was successfully created.' }
          format.json { render :show, status: :created, location: @experience }
        else
          format.html { redirect_to experiences_path, notice: 'Experience was successfully created.' }
          format.json { render :show, status: :created, location: @experience }
        end  
      else
        format.html { render :new }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiences/1
  # PATCH/PUT /experiences/1.json
  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.html { redirect_to experiences_path, notice: 'Experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @experience }
      else
        format.html { render :edit }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/1
  # DELETE /experiences/1.json
  def destroy
    @experience.destroy
    respond_to do |format|
      format.html { redirect_to experiences_url, notice: 'Experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report
    employee_params = params.symbolize_keys
    employee_id = employee_params[:experience]["employee_id"]
    employee_data = Employee.find(employee_id)
    html = EmployeesHelper.experience_template(employee_data,employee_data.experiences,1) 
    kit = PDFKit.new(html)
    kit.to_file("public/experience/experience-#{employee_id}.pdf")
    result = employee_data.update(exp_report: true)
    if result
      render json: {status: 200,message: "Successfully generated experience report!"}
    else
      render json: {status: 500,error: result.errors.full_messages}
    end 
  end

  def report_all
    html = EmployeesHelper.experience_template({},{},0)
    kit = PDFKit.new(html)
    if kit.to_file("public/experience/group/experience-group.pdf")
      render json: {status: 200,message: "Successfully generated experience report!"}
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(:from_date, :to_date, :title, :description, :employee_id,:note)
    end
end
