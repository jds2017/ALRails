class Lecture < ApplicationRecord
  belongs_to :question_set
  belongs_to :course
end
