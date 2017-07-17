class Lecture < ApplicationRecord
  belongs_to :question_set

  has_one :course_to_lecture_junction
  has_one :course, through: :course_to_lecture_junction
  
  #compute out of all the responses, how many corresponded to each answer
  #returns hash keyed by answer id with value for % responses with that answer id
  def self.compute_percentages (q)
    @responses = Response.where(question: q)
    @answers = Answer.where(question: q)
    @total = @responses.length
    hash = Hash.new()
    @answers.each{|key| hash[key.id] = 0}
    @responses.each{|key| hash[key.answer_id] += 1}
    hash.each {|key, value| hash[key] = (value.to_f / @total) }
    return hash
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
    return 100.0 * right / total
  end
end
