class Course < ApplicationRecord
  has_many :registrations
  has_many :users, through: :registrations
  has_many :questions, foreign_key: 'course_name', primary_key: 'name'
  has_many :course_to_lecture_junctions
  has_many :lectures, through: :course_to_lecture_junctions
  
  before_create :generate_key

  validates :semester, inclusion: { in: %w(SUMMER FALL SPRING) }

  def to_s
    self.name
  end

  def pct_correct
    right = 0
    total = 0
    self.lectures.each do |lec|
      responses = Response.where(lecture: lec)
      total += responses.size
      right_responses = responses.select { |r| r.is_correct? }
      right += right_responses.size
    end
    return 100.0 * right / total
  end

  def pct_correct_by_user(user)
    right = 0
    total = 0
    self.lectures.each do |lec|
      responses = Response.where(lecture: lec, user: user)
      total += responses.size
      right_responses = responses.select { |r| r.is_correct? }
      right += right_responses.size
    end
    return 100.0 * right / total
  end

  private # student_key generator
    def generate_key
      self.student_key = SecureRandom.urlsafe_base64
    end
end
