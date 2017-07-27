class QuestionSet < ApplicationRecord
  has_many :question_set_junctions, :dependent => :destroy
  has_many :questions, through: :question_set_junctions

  def readonly_copy
    set = QuestionSet.new(name: self.name + ' (clone)')
    set.is_readonly = true
    set.questions = self.questions
    set.save!
    set
  end

  def to_s
    self.name
  end

  def course_name
    questions.first&.course_name
  end
end
