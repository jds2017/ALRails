class Course < ApplicationRecord
  has_many :registrations
  has_many :users, through: :registrations
  has_many :questions, foreign_key: 'course_name', primary_key: 'name'
  before_create :generate_key

  validates :semester, inclusion: { in: %w(SUMMER FALL SPRING) }

  def to_s
    self.name
  end

  private # student_key generator
    def generate_key
      self.student_key = SecureRandom.urlsafe_base64
    end
end
