json.extract! tracker, :id, :title, :description, :project_id, :employee_id, :created_at, :updated_at
json.url tracker_url(tracker, format: :json)
