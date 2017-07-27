class CourseToLectureJunction < ApplicationRecord
  belongs_to :course
  belongs_to :lecture
  has_many :registrations, dependent: :destroy
end
