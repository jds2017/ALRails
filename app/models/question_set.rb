class QuestionSet < ApplicationRecord
  validates :course_name, presence: true
  has_many :question_set_junctions, :dependent => :destroy
  has_many :questions, through: :question_set_junctions

  def readonly_copy
    set = QuestionSet.new(name: self.name + ' (clone)')
    set.is_readonly = true
    set.course_name = self.course_name
    set.questions = self.questions
    set
  end

  def to_s
    self.name
  end
end
