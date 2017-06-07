class Question < ApplicationRecord
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true

  has_many :question_set_junctions
  has_many :questions, through: :question_set_junctions
end
