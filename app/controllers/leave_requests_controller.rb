class LeaveRequestsController < ApplicationController
  before_action :set_leave_request, only: [:show, :edit, :update, :destroy]

  # GET /leave_requests
  # GET /leave_requests.json
  def index
    if params[:type] == "active"
      @leave_requests = LeaveRequest.where(to: Time.now.beginning_of_day..Time.now.end_of_day)
    else
      case current_employee.role.role
      when "employee"
        @leave_requests = current_employee.leave_requests
      when "team_leader"
        @leave_requests = LeaveRequest.team_leader_leave_requests
      when "team_manager"
        @leave_requests = LeaveRequest.team_manager_leave_requests
      when "hr"
        @leave_requests = LeaveRequest.hr_leave_requests
      when "president"
        @leave_requests = LeaveRequest.where('president_id = ? OR reporting_manager_id = ?',current_employee.id,current_employee.id)
      end
    end  
  end

  # GET /leave_requests/1
  # GET /leave_requests/1.json
  def show
  end

  # GET /leave_requests/new
  def new
    @leave_request = LeaveRequest.new
  end

  # GET /leave_requests/1/edit
  def edit
  end

  # POST /leave_requests
  # POST /leave_requests.json
  def create
    @leave_request = LeaveRequest.new(leave_request_params)
    respond_to do |format|
      if @leave_request.save!
        format.html { redirect_to @leave_request, notice: 'Leave request was successfully created.' }
        format.json { render :show, status: :created, location: @leave_request }
      else
        format.html { render :new }
        format.json { render json: @leave_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leave_requests/1
  # PATCH/PUT /leave_requests/1.json
  def update
    respond_to do |format|
      if @leave_request.update(leave_request_params)
        format.html { redirect_to @leave_request, notice: 'Leave request was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave_request }
      else
        format.html { render :edit }
        format.json { render json: @leave_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leave_requests/1
  # DELETE /leave_requests/1.json
  def destroy
    @leave_request.destroy
    respond_to do |format|
      format.html { redirect_to leave_requests_url, notice: 'Leave request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_status
    @leave_response = LeaveResponse.new(leave_response_params)
    if @leave_response.save!
      if leave_response_params[:reporting_manager_action] == "approved"
        render json: {status: 200,message: "Successfully approved!"}
      elsif leave_response_params[:reporting_manager_action] == "cancel"
        render json: {status: 200,message: "Successfully cencelled!"}  
      else
        render json: {status: 200,message: "Successfully rejected!"}
      end 
    else
      render json: {status: 500,error: @leave_response.errors.full_messages}
    end
  end

  def forward
    @leave_response = LeaveResponse.new(leave_response_params)
    if @leave_response.save
      employees = Employee.where(id: leave_response_params[:reporting_manager_id])
      leave_request = false
      employees.each do |employee|
        byebug
        if employee.user_role == 'president'
          leave_request = @leave_response.leave_request.update!(president_id: employee.id) 
        elsif employee.user_role == 'team_manager'
          leave_request = @leave_response.leave_request.update!(reporting_manager_id: employee.id) 
        else
          leave_request = false
        end            
      end    
      if leave_request
        render json: {status: 200,message: "Successfully forwarded!"}
      else
        render json: {status: 500,error: leave_request.errors.full_messages}
      end
    else
      render json: {status: 500,error: @leave_response.errors.full_messages}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_request
      @leave_request = LeaveRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_request_params
      params.require(:leave_request).permit(:from,:to,:subject,:description,:is_office_wide_meeting,:is_staff_meeting,:is_client_visit_day,:is_client_visit_week,:is_client_part,:is_special_approval_needed,:is_training_schedule,:coverage_plans,:vacation_hours,:sick_hours,:date_vacation_accrues,:date_requested_off,:purspose_timeoff,:is_make_up_or_sicktime,:leave_hour_type,:sick_hour_usage,:vocation_hour_usage,:make_up_time_usage,:employee_id,:cover_id,:team_lead_id,:team_manager_id)
    end

    def leave_response_params
      @params = params.symbolize_keys
      {
        leave_request_id: Integer(@params[:leave_request]["leave_request_id"]),
        employee_id: Integer(@params[:leave_request]["employee_id"]),
        role: @params[:leave_request]["employee_role"],
        comment: @params[:leave_request]["comment"],
        reporting_manager_action: @params[:leave_request]["action"],
        reporting_manager_id: @params[:leave_request]["reporting_manager_id"],
        response_date: Date.current
      }
    end


end
