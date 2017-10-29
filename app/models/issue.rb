class Issue < ApplicationRecord
  
  STATUS = {"Pending" => 1, "In Progress" => 2, "Completed" => 3 }

  belongs_to :creator,class_name: "Employee",foreign_key: "creator_id"
  belongs_to :solver,class_name: "Employee",foreign_key: "solved_by"

  def issue_status
  	case(status)
  	when 1
  		"Pending"
  	when 2
  		"In Progress"
  	when 3
  		"Completed"
  	end
  end

  def creator
    Employee.find(creator_id) if creator_id
  end

  def solver
    Employee.find(solved_by) if solved_by
  end
end
