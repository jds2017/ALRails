class LivelectureController < ApplicationController
  def show
    @lecture = Lecture.find_by(id: params[:lecture])
    @questions = @lecture.question_set.questions
    render "livelecture"
  end
end
