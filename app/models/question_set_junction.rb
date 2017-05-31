class QuestionSetJunction < ApplicationRecord
  belongs_to :question
  belongs_to :question_set
end
