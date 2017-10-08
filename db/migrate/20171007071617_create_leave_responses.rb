class CreateLeaveResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_responses do |t|
    	t.integer :leave_request_id
    	t.integer :employee_id
    	t.string  :role
    	t.datetime :response_date
        t.timestamps
    end
    add_foreign_key :leave_responses,:leave_requests
    add_foreign_key :leave_responses,:employees
  end
end
