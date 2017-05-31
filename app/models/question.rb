class Question < ApplicationRecord
  has_many :answers

  has_many :question_set_junctions
  has_many :questions, through: :question_set_junctions
end
