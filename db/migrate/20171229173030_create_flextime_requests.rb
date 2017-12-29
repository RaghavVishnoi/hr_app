class CreateFlextimeRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :flextime_requests do |t|
        t.integer :to
        t.integer :from
        t.datetime :date
        t.datetime :beginning_date
        t.datetime :ending_date
        t.text     :reason
        t.boolean :is_schedule_revoked
        t.string  :day_schedule_revoked
        t.text :reason_schedule_revoked
        t.boolean :issues_resolved
        t.datetime :issue_resolve_date
        t.integer :employee_id
        t.integer :team_lead_id
        t.integer :team_manager_id
        t.boolean :is_permission_issue
        t.boolean :is_employee_on_time
        t.boolean :is_flexible_schedule_revoked
        t.boolean :is_admin_issues_resolved
        t.boolean :is_hr_approval
        t.boolean :is_forward_person_approval
        t.boolean :terms_and_condition
        t.timestamps
    end
    add_foreign_key :flextime_requests,:employees,column: :to
    add_foreign_key :flextime_requests,:employees,column: :from
    add_foreign_key :flextime_requests,:employees
    add_foreign_key :flextime_requests,:employees,column: :team_lead_id
    add_foreign_key :flextime_requests,:employees,column: :team_manager_id
  end
end
