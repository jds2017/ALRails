class User < ApplicationRecord
  has_many :registrations
  has_many :courses, through: :registrations
  has_many :responses

  def courses_as_assistant
    Registration.where(user: self, role: 'ASSISTANT').map { |r| r.course }
  end

  def courses_as_professor
    Registration.where(user: self, role: 'PROFESSOR').map { |r| r.course }
  end

  def to_s
    self.username
  end
end
