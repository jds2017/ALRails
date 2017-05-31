class QuestionSet < ApplicationRecord
  has_many :question_set_junctions
  has_many :questions, through: :question_set_junctions
end
