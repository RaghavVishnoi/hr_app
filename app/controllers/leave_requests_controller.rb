class LeaveRequestsController < ApplicationController
  before_action :set_leave_request, only: [:show, :edit, :update, :destroy]

  # GET /leave_requests
  # GET /leave_requests.json
  def index
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
      if @leave_request.save
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
      else
        render json: {status: 200,message: "Successfully rejected!"}
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
      params.require(:leave_request).permit(:from,:to,:subject,:description,:is_office_wide_meeting,:is_staff_meeting,:is_client_visit_day,:is_client_visit_week,:is_client_part,:is_special_approval_needed,:is_training_schedule,:coverage_plans,:vacation_hours,:sick_hours,:date_vacation_accrues,:date_requested_off,:purspose_timeoff,:is_make_up_or_sicktime,:employee_id,:cover_id,:team_lead_id,:team_manager_id)
    end

    def leave_response_params
      @params = params.symbolize_keys
      {
        leave_request_id: Integer(@params[:leave_request]["leave_request_id"]),
        employee_id: Integer(@params[:leave_request]["employee_id"]),
        role: @params[:leave_request]["employee_role"],
        reporting_manager_action: @params[:leave_request]["action"]
      }
    end


end
