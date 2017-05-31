json.extract! response, :id, :lecture_id, :user_id, :question_id, :answer_id, :created_at, :updated_at
json.url response_url(response, format: :json)
