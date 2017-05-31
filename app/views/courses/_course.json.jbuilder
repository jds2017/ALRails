json.extract! course, :id, :year, :semester, :name, :student_key, :created_at, :updated_at
json.url course_url(course, format: :json)
