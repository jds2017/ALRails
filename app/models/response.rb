class Response < ApplicationRecord
  validates :lecture, :user, :question, :answer, presence: true

  belongs_to :lecture
  belongs_to :user
  belongs_to :question
  belongs_to :answer

  def is_correct?
    self.question.correct_answers.include? self.answer
  end
end
