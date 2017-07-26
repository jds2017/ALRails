class User < ApplicationRecord
  has_many :registrations
  has_many :courses, through: :registrations
  has_many :responses

  def teaches? (course)
    Registration.exists?(user: self, role: 'INSTRUCTOR', course: course)
  end

  def courses_as_instructor
    Registration.where(user: self, role: 'INSTRUCTOR').map { |r| r.course }
  end

  def to_s
    self.username
  end
end
