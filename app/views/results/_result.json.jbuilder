json.extract! result, :id, :user_id, :exam_id, :obtained_marks, :correct_ans, :incorrect_ans, :created_at, :updated_at
json.url result_url(result, format: :json)
