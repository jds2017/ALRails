json.extract! user, :id, :username, :fname, :lname, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)
