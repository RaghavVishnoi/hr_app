json.extract! perf_review_request, :id, :reviewer_id, :reviewee_id, :flag, :avg, :created_at, :updated_at
json.url perf_review_request_url(perf_review_request, format: :json)
