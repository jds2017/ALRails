class Lecture < ApplicationRecord
  belongs_to :question_set
  
  #compute out of all the responses, how many corresponded to each answer
  #returns hash keyed by answer id with value for % responses with that answer id
  def self.compute_percentages (q)
    @responses = Response.where(question: q)
    @answers = Answer.where(question: q)
    @total = @responses.length
    hash = Hash.new(0)
    @answers.each{|key| hash[key.id] = 0}
    @responses.each{|key| hash[key.answer_id] += 1}
    hash.each {|key, value| hash[key] = (value.to_f / @total) }
    return hash
  end
end
