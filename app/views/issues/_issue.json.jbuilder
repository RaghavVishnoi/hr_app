json.extract! issue, :id, :title, :description, :creator_id, :solved_by, :created_at, :updated_at
json.url issue_url(issue, format: :json)
