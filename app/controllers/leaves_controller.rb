class LeavesController < ApplicationController
  before_action :set_leave, only: [:show, :edit, :update, :destroy]

  # GET /leaves
  # GET /leaves.json
  def index
  
    @my_leaves = Leave.where(employee_id: current_employee.id).order('id DESC')
    if current_employee.user_role == 'team_leader' || current_employee.user_role == 'hr' || current_employee.user_role == 'president'
      @leaves = Leave.all
    end
  end

  # GET /leaves/1
  # GET /leaves/1.json
  def show
  end

  # GET /leaves/new
  def new
    @leave = Leave.new
    if current_employee.employee?
      @team_members = Employee.where(id: current_employee.project_team_member.project_team.project_team_members.pluck(:employee_id)).where(role_id: Role.find_by(role: 'employee')).where.not(id: current_employee.id)
    elsif current_employee.team_leader?
      @team_members = Employee.where(role_id: Role.find_by(role: 'team_leader')).where.not(id: current_employee.id)
    elsif current_employee.team_manager?
      @team_members = Employee.where(role_id: Role.find_by(role: 'team_manager'))
    elsif current_employee.hr?
      @assigned_to = Employee.where(role_id: 2).first.id
    end
  end

  # GET /leaves/1/edit
  def edit
    @team_members = Employee.where(id: current_employee.project_team_member.project_team.project_team_members.pluck(:employee_id)).where(role_id: 5).where.not(id: current_employee.id)
  end

  # POST /leaves
  # POST /leaves.json
  def create
    @leave = Leave.new(leave_params)
    @leave.employee_id = leave_params[:employee_id] if current_employee.employee?
    respond_to do |format|
      if @leave.save
        format.html { redirect_to new_leave_work_assign_path, notice: 'Leave was successfully created.' }
        format.json { render :show, status: :created, location: @leave }
      else
        format.html { render :new }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
 #   @email= Employee.find(leave_params[:assigned_to]).email
  #  LeaveRequestMailer.leave_email(@email,@leave.id).deliver_later
  end

  # PATCH/PUT /leaves/1
  # PATCH/PUT /leaves/1.json
  def update
    

    respond_to do |format|
      if @leave.update(leave_params)
        format.html { redirect_to @leave, notice: 'Leave was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave }
      else
        format.html { render :edit }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
    @leave_id=params[:id]
    @applied_email=Leave.find(@leave_id).employee.email
    if leave_params[:employee_accepted_at].present?
      @tl_email_id = Employee.where(id: current_employee.project_team_member.project_team.project_team_members.pluck(:employee_id)).where(role_id: 4).first.email
      LeaveRequestMailer.leave_email(@tl_email_id,@leave_id).deliver_later
    elsif leave_params[:tl_accepted_at].present? 
      @pm_email =  Employee.where(id: current_employee.project_team_member.project_team.project_team_members.pluck(:employee_id)).where(role_id: 3).first.email
      LeaveRequestMailer.leave_email(@pm_email,@leave_id).deliver_later
    elsif leave_params[:tm_accepted_at].present?
      @hr_email =  Employee.where(role_id: 2).first.email
      LeaveRequestMailer.leave_email(@hr_email,@leave_id).deliver_later
    elsif leave_params[:hr_accepted_at].present?
      @pre_email =  Employee.where(role_id: 1).first.email
      LeaveRequestMailer.leave_email(@pre_email,@leave_id).deliver_later
    elsif leave_params[:president_accepted_at].present?
      LeaveRequestMailer.leave_email(@applied_email,@leave_id).deliver_later
      LeaveRequestMailer.leave_email(@tl_email_id,@leave_id).deliver_later
      LeaveRequestMailer.leave_email(@pm_email,@leave_id).deliver_later
      LeaveRequestMailer.leave_email(@hr_email,@leave_id).deliver_later
      LeaveRequestMailer.leave_email(@pre_email,@leave_id).deliver_later  
    end
  end

  # DELETE /leaves/1
  # DELETE /leaves/1.json
  def destroy
    @leave.destroy
    respond_to do |format|
      format.html { redirect_to leaves_url, notice: 'Leave was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave
      @leave = Leave.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_params
      params.require(:leave).permit(:subject, :body, :from_date, :to_date, :assigned_to, :employee_id ,:employee_accepted_at, :tl_accepted_at, :tm_accepted_at, :hr_accepted_at, :president_accepted_at)
    end
end
