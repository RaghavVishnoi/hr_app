class ResultReceiver < ApplicationRecord
	belongs_to :employee,class_name: 'Employee',foreign_key: :receiver_id
	belongs_to :exam
end
