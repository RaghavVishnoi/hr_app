class CreateLeaveRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_requests do |t|
        t.datetime  		:from
        t.datetime  		:to
        t.string    		:subject
        t.text      		:description
		t.boolean	        :is_office_wide_meeting
		t.boolean			:is_staff_meeting
		t.boolean			:is_client_visit_day
		t.boolean			:is_client_visit_week
		t.boolean			:is_client_part
		t.boolean			:is_special_approval_needed
		t.boolean			:is_training_schedule
		t.string			:coverage_plans
		t.float				:vacation_hours
		t.float				:sick_hours
		t.datetime			:date_vacation_accrues
		t.datetime			:date_requested_off
		t.string			:purspose_timeoff
		t.boolean			:is_make_up_or_sicktime
		t.integer           :employee_id
		t.integer			:cover_id
		t.integer			:team_lead_id
		t.integer			:team_manager_id
		t.string			:status
        t.timestamps
    end
    add_foreign_key :leave_requests,:employees
    add_foreign_key :leave_requests,:employees,column: :cover_id
    add_foreign_key :leave_requests,:employees,column: :team_lead_id
    add_foreign_key :leave_requests,:employees,column: :team_manager_id
  end
end
