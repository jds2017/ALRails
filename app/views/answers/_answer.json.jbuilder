json.extract! answer, :id, :answer, :is_correct, :question_id, :created_at, :updated_at
json.url answer_url(answer, format: :json)
