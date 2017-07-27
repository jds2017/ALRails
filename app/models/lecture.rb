class Lecture < ApplicationRecord
  validates :course, :question_set, presence: true
  belongs_to :question_set

  has_one :course_to_lecture_junction
  has_one :course, through: :course_to_lecture_junction
  belongs_to :question_set

  def question_response_average(q)
    @responses = Response.where(question: q, lecture: self)
    @answers = q.answers
    @total = @responses.length
    answer_counts = Hash.new()
    @answers.each { |answer| answer_counts[answer] = 0} 
    @responses.each { |response| answer_counts[response.answer] += 1 }
    answer_counts.each { |answer, count| answer_counts[answer] = 100 * (count.to_f / @total) }
    return answer_counts
  end

  def response_average
    questions = self.question_set.questions
    return questions.map { |q| [q, question_response_average(q)] }.to_h
  end

  def question_average(question)
    total = 0
    right = 0
    responses = Response.where(lecture: self, question: question)
    total = responses.size
    right_responses = responses.select { |r| r.is_correct? }
    right = right_responses.size
    return 100.0 * right / total    
  end

  def overall_average
    total = 0
    right = 0
    responses = Response.where(lecture: self)
    total = responses.size
    right_responses = responses.select { |r| r.is_correct? }
    right = right_responses.size
    return 100.0 * right / total
  end

  def user_average(user)
    total = 0
    right = 0
    responses = Response.where(lecture: self, user: user)
    total = responses.size
    right_responses = responses.select { |r| r.is_correct? }
    right = right_responses.size
    average = '%.2f' % (100.0 * right / total)
    if (average == "NaN")
        if self.completed?
            return "Absent"
        else
            return "-"
        end
    else
        return average
    end
  end
end