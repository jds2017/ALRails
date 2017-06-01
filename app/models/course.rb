class Course < ApplicationRecord
  has_many :registrations
  has_many :users, through: :registrations

  validates :semester, inclusion: { in: %w(SUMMER FALL SPRING) }

  def to_s
    self.name
  end
end
