json.extract! registration, :id, :role, :user_id, :course_id, :created_at, :updated_at
json.url registration_url(registration, format: :json)
