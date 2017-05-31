class Course < ApplicationRecord
  has_many :registrations
  has_many :users, through: :registrations

  validates :semester, inclusion: { in: %w(SUMMER FALL SPRING) }
end
