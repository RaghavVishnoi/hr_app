json.extract! question, :id, :exam_id, :question, :question_type, :options, :answer, :created_at, :updated_at
json.url question_url(question, format: :json)
