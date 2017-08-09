json.extract! response, :id, :question_id, :answer, :employee_id, :created_at, :updated_at
json.url response_url(response, format: :json)
