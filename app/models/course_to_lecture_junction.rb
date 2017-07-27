class CourseToLectureJunction < ApplicationRecord
  belongs_to :course
  belongs_to :lecture
end
