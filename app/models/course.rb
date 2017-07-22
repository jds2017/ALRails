class Course < ApplicationRecord
  has_many :registrations
  has_many :users, through: :registrations
  has_many :questions, foreign_key: 'course_name', primary_key: 'name'
  has_many :course_to_lecture_junctions
  has_many :lectures, through: :course_to_lecture_junctions
  
  before_create :generate_key

  validates :semester, inclusion: { in: %w(SUMMER FALL SPRING) }
  validates_format_of :name, :with => /\A[A-Z]{2,4}[0-9]{4}\z/,
    message: 'name must be a few uppercase letters followed by four digits' 

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

  def timeseries_by_user(user)
    @data = []
    current_average = 0.0
    tally = 0
    responses = []
    self.lectures.each do |l|
      responses << Response.where(lecture: l, user: user)
    end
    responses.flatten!
    responses.sort_by!(&:created_at)
    responses.each do |r|
        point = 0
        point = 1 if r.is_correct?
        current_average = (current_average * tally + point)/(tally+1)
        tally += 1
        @data << [r.created_at.to_time.to_i*1000, current_average*100]
    end
    return @data
  end

  def timeseries
    @data = []
    current_average = 0.0
    tally = 0
    responses = []
    self.lectures.each do |l|
      responses << Response.where(lecture: l)
    end
    responses.flatten!
    responses.sort_by!(&:created_at)
    responses.each do |r|
        point = 0
        point = 1 if r.is_correct?
        current_average = (current_average * tally + point)/(tally+1)
        tally += 1
        @data << [r.created_at.to_time.to_i*1000, current_average*100]
    end
    return @data
  end
    
  def students
    Registration.where(course: self, role: 'STUDENT').map { |r| r.user }
  end

  def has_completed_lectures
    completed = false
    self.lectures.each do |l|
      if l.completed
        completed = true
      end
    end
    return completed
  end

  private # student_key generator
    def generate_key
      self.student_key = SecureRandom.urlsafe_base64
    end
end
