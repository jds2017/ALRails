require 'json'

class Question < ApplicationRecord
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true, :reject_if => proc { |a| a[:answer].blank? }

  has_many :question_set_junctions

  has_many :question_to_tag_junctions
  has_many :tags, through: :question_to_tag_junctions

  validates :course_name, presence: true

  def correct_answers
    answers.find_all { |a| a.is_correct }
  end

  def course
    Course.find_by(name: self.course_name)
  end

  def body_as_text
    delta = JSON.parse(self.body)
    text = delta['ops'].select{|i| i['insert'].class == String }
    text = text.map { |n| n['insert'] }
    text = text.join()
  end
end

# Body: {"ops":[{"insert":"hello \n\nSomething"},{"attributes":{"code-block":true},"insert":"\n\n"},{"insert":"\nelse\n"}]}
# [{"insert":"hello \n\nSomething"},{"attributes":{"code-block":true},"insert":"\n\n"},{"insert":"\nelse\n"}]}
