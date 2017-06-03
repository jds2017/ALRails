class Course < ApplicationRecord
  has_many :registrations
  has_many :users, through: :registrations
  has_many :questions, foreign_key: 'course_name', primary_key: 'name'

  validates :semester, inclusion: { in: %w(SUMMER FALL SPRING) }

  def to_s
    self.name
  end
end
