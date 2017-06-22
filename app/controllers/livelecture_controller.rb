class LivelectureController < ApplicationController
  def start
    @lecture = Lecture.find_by(id: params[:lecture])
    render "teacher"
  end

  def join
    @lecture = Lecture.find_by(id: params[:lecture])
    render "student"
  end
end
