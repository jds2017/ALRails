class Question < ApplicationRecord
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true

  has_many :question_set_junctions

  validates :course_name, presence: true

  def correct_answers
    answers.find_all { |a| a.is_correct }
  end
end
