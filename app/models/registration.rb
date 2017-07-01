class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :role, inclusion: { in: %w(STUDENT INSTRUCTOR) }
end
