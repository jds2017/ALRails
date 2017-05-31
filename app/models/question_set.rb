class QuestionSet < ApplicationRecord
  has_many :question_set_junctions
  has_many :questions, through: :question_set_junctions

  has_many :question_to_tag_junctions
  has_many :tags, through: :question_to_tag_junctions
end
