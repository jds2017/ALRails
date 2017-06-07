class Question < ApplicationRecord
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true

  has_many :question_set_junctions
  has_many :questions, through: :question_set_junctions

  def correct_answers
    answers.find_all { |a| a.is_correct }
  end
end
