class LeaveWorkAssignController < ApplicationController

 # create_table "leave_work_assigns", force: :cascade do |t|
 #    t.integer  "leave_id"
 #    t.string   "assign_to"
 #    t.integer  "employee_id"
 #    t.date     "assign_date"
def index
   @event = Event.new
end
def new
 @assign = LeaveWorkAssign.new
end

def create
	params_data=params[:leave_work_assing][0].to_a
	@user_id=current_employee.id
    @leave_id =params[:leave_work_assign][:leave_id]	
    @leave_sub=Leave.find(@leave_id).subject
    @team_id=current_employee.project_team_member.project_team.id
	begin
    params_data.each do |key,value|
    
      assign_date = key.to_date
      assign_user = value
      @emp= Employee.find(assign_user)
      
      LeaveWorkAssign.create(leave_id: @leave_id, assign_to: @user_id.to_s,employee_id: @emp.id,assign_date: assign_date)
      Event.create(title: @leave_sub,start: assign_date,end: assign_date,employee_id_id: @emp.id,for_team: @team_id)
      LeaveRequestMailer.leave_email(@emp.email,@leave_id).deliver_later
    end
  rescue 
    redirect_to new_leave_work_assign_path
  end
     Leave.find(@leave_id).update(all_assign: 1)
   redirect_to leaves_path

    # LeaveWorkAssign.where(leave_id: @leave_id).map(&:employee)

end

end
