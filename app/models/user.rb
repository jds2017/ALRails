class User < ApplicationRecord
  has_many :registrations
  has_many :courses, through: :registrations
  has_many :responses

  def courses_as_instructor
    Registration.where(user: self, role: ['ASSISTANT','PROFESSOR']).map { |r| r.course }
  end

  def to_s
    self.username
  end
end
