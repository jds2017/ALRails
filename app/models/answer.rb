class Answer < ApplicationRecord
  validates :answer, presence: true
  
  belongs_to :question

  def to_s
    answer
  end
end
